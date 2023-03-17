// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glaengage/backend/auth.dart';
import 'package:glaengage/root/pages/public_profile.dart';
import 'package:provider/provider.dart';
import '../../backend/models.dart';
import '../../backend/providers.dart';
import 'filters.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // SpeechToText speechToText = SpeechToText();
  TextEditingController search = TextEditingController();
  var isListening = false;
  bool showClear = false;
  List<ProfileModel>? searchResult;
  List<ProfileModel>? suggestion;
  List<String> sortby = [
    'year',
    'company',
    'passoutyear',
    'course',
    'addmissionyear',
    'name',
    'branch',
  ];

  void clear() {
    search.clear();
  }

  @override
  initState() {
    super.initState();
    suggestionlist();
  }

  suggestionlist() async {
    // List<ProfileModel> s = await Auth.suggestion(
    //     context.watch<UserProvider>().getProfile!.branch!);
    List<ProfileModel> s = await Auth.suggestion("cs");
    setState(() {
      suggestion = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PublicProfile(
                                      email: FirebaseAuth
                                          .instance.currentUser!.email!,
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                              '${context.watch<UserProvider>().getProfile!.imgUrl}'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 120,
                      height: 45,
                      child: TextFormField(
                        controller: search,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              showClear = true;
                            });
                          } else {
                            setState(() {
                              showClear = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15.0),
                          border: const UnderlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Search...",
                          suffixIcon: search.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    size: 25,
                                    color: Colors.grey.shade600,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      FocusScope.of(context).unfocus();
                                      clear();
                                    });
                                  },
                                )
                              : null,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (search.text.isNotEmpty) {
                            setState(() {
                              searchResult = null;
                            });
                            List<ProfileModel> d =
                                await Auth.searchUser(search.text);
                            setState(() {
                              searchResult = d;
                            });
                          }
                        },
                        icon: Icon(Icons.search_rounded)),
                  ],
                ),
                // IconButton(
                //     onPressed: () {
                //       //sortby function
                //       showModalBottomSheet(
                //           context: context,
                //           builder: (context) {
                //             return ListView.builder(
                //               itemCount: sortby.length,
                //               itemBuilder: (BuildContext context, int index) {
                //                 return ListTile(
                //                   title: Text(sortby[index]),
                //                 );
                //               },
                //             );
                //           });
                //     },
                //     icon: Icon(Icons.sort_rounded)),
                // IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => MyFilterPage(),
                //           ));
                //     },
                //     icon: Icon(Icons.filter_alt)),
              ],
            ),
          ),
          searchResult != null
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 68,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: searchResult!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PublicProfile(
                                    email:
                                        searchResult!.elementAt(index).mail!),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: searchResult!
                                          .elementAt(index)
                                          .imgUrl !=
                                      null
                                  ? NetworkImage(
                                      searchResult!.elementAt(index).imgUrl!)
                                  : null,
                              child:
                                  searchResult!.elementAt(index).imgUrl == null
                                      ? const Icon(Icons.person_4)
                                      : null,
                            ),
                            title: Text(searchResult!.elementAt(index).name!),
                            subtitle: Text(
                                "${searchResult!.elementAt(index).course} (${searchResult!.elementAt(index).branch}) \n"
                                " ${searchResult!.elementAt(index).mail!}"),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox.shrink(),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                bottom: 12,
                top: 12,
              ),
              child: Text(
                "Suggestions",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Container(
            child: suggestion != null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 68,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: suggestion!.length - 1,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PublicProfile(
                                      email:
                                          suggestion!.elementAt(index).mail!),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: suggestion!
                                            .elementAt(index)
                                            .imgUrl !=
                                        null
                                    ? NetworkImage(
                                        suggestion!.elementAt(index).imgUrl!)
                                    : null,
                                child:
                                    suggestion!.elementAt(index).imgUrl == null
                                        ? const Icon(Icons.person_4)
                                        : null,
                              ),
                              title: Text(suggestion!.elementAt(index).name!),
                              subtitle: Text(
                                  // "${suggestion!.elementAt(index).course} (${searchResult?.elementAt(index).branch}) \n"
                                  " ${suggestion!.elementAt(index).mail!}"),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
