import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gla_engage/backend/auth.dart';
import 'package:gla_engage/root/pages/public_profile.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../backend/models.dart';
import '../../backend/providers.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SpeechToText speechToText = SpeechToText();
  TextEditingController search = TextEditingController();
  var isListening = false;
  bool showClear = false;

  List<ProfileModel>? searchResult;

  // requestMicrophonePermission() async {
  //   bool micPermission = await Permission.microphone.isGranted;
  //   if (!micPermission) {
  //     PermissionStatus t = await Permission.microphone.request();
  //     micPermission = t.isGranted;
  //   } else {
  //     log("Your Already Have Permission");
  //   }
  // }

  void clear() {
    search.clear();
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
                        icon: const Icon(Icons.search))
                    // IconButton(
                    //   icon: Icon(
                    //     isListening ? Icons.mic : Icons.mic_none_outlined,
                    //     size: 30,
                    //     color: Colors.grey.shade600,
                    //   ),
                    //   onPressed: () {
                    //     gettingvoice();
                    //     showDialog(
                    //       barrierDismissible: false,
                    //       context: context,
                    //       builder: (context) {
                    //         Future.delayed(const Duration(seconds: 5), () {
                    //           Navigator.of(context).pop(true);
                    //         });
                    //         return AlertDialog(
                    //           alignment: Alignment.center,
                    //           content: Container(
                    //             height: 250,
                    //             width: 100,
                    //             alignment: Alignment.center,
                    //             child: Column(
                    //               children: [
                    //                 AvatarGlow(
                    //                   endRadius: 75.0,
                    //                   animate: isListening,
                    //                   duration:
                    //                       const Duration(milliseconds: 2000),
                    //                   glowColor: Colors.green.shade300,
                    //                   repeat: true,
                    //                   showTwoGlows: true,
                    //                   repeatPauseDuration:
                    //                       const Duration(milliseconds: 100),
                    //                   child: IconButton(
                    //                       onPressed: () {},
                    //                       icon: const Icon(
                    //                         Icons.mic_none_outlined,
                    //                         size: 50,
                    //                       )),
                    //                 ),
                    //                 const Text(
                    //                   "Listening...",
                    //                   style: TextStyle(),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //           shape: const RoundedRectangleBorder(
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(30))),
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                  ],
                ),
                //  Column .................
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
                            // title: Text(searcheduser.uid!),
                            subtitle: Text(
                                "${searchResult!.elementAt(index).course} (${searchResult!.elementAt(index).branch}) \n"
                                " ${searchResult!.elementAt(index).mail!}"),
                            // trailing: IconButton(
                            //     onPressed: () async {},
                            //     icon: const Icon(Icons.message_rounded)),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox.shrink()
          // Container(
          //   child: StreamBuilder(
          //     stream: FirebaseFirestore.instance
          //         .collection("Users")
          //         .where("mail", isGreaterThanOrEqualTo: search.text)
          //         // .where("email", isNotEqualTo: Widget.Usermode.email)
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.active) {
          //         if (snapshot.hasData) {
          //           QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
          //           if (datasnapshot.docs.length > 0) {
          //             Map<String, dynamic> usermap =
          //                 datasnapshot.docs[0].data() as Map<String, dynamic>;
          //             StudentModel searcheduser = StudentModel.fromMap(usermap);
          //             return ListTile(
          //               leading: CircleAvatar(
          //                 backgroundImage: NetworkImage(searcheduser.imgUrl!),
          //               ),
          //               title: Text(searcheduser.name!),
          //               // title: Text(searcheduser.uid!),
          //               subtitle: Text(searcheduser.mail!),
          //               trailing: IconButton(
          //                   onPressed: () async {},
          //                   icon: Icon(Icons.message_rounded)),
          //             );
          //           } else {
          //             return Text("No Result Found");
          //           }
          //           // } else if (snapshot.hasError) {
          //         } else {
          //           return Text("No Result Found");
          //         }
          //       } else {
          //         return Container(
          //             alignment: Alignment.center,
          //             child: CircularProgressIndicator());
          //       }
          //     },
          //   ),
          // )
          // StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //       .collection("Users")
          //       .where("mail", isGreaterThanOrEqualTo: search.text)
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.active) {
          //       if (snapshot.hasData) {
          //         QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
          //         if (datasnapshot.docs.isNotEmpty) {
          //           return ListView.builder(
          //             shrinkWrap: true,
          //             itemCount: datasnapshot.docs.length,
          //             itemBuilder: (context, index) {
          //               Map<String, dynamic> usermap = datasnapshot.docs[index]
          //                   .data() as Map<String, dynamic>;
          //               ProfileModel searcheduser =
          //                   ProfileModel.fromMap(usermap);
          //               return ListTile(
          //                 onTap: () {
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (context) =>
          //                           PublicProfile(email: searcheduser.mail!),
          //                     ),
          //                   );
          //                 },
          //                 leading: CircleAvatar(
          //                   backgroundImage: searcheduser.imgUrl != null
          //                       ? NetworkImage(searcheduser.imgUrl!)
          //                       : null,
          //                   child: searcheduser.imgUrl == null
          //                       // ? Icon(Icons.person)
          //                       ? Image.asset("assets/images/profile.png")
          //                       : null,
          //                 ),
          //                 title: Text(searcheduser.name!),
          //                 subtitle: Text(searcheduser.mail!),
          //                 trailing: IconButton(
          //                     onPressed: () async {},
          //                     icon: const Icon(Icons.message_rounded)),
          //               );
          //             },
          //           );
          //         } else {
          //           return const Text("No Result Found");
          //         }
          //       } else {
          //         return const Text("No Result Found");
          //       }
          //     } else {
          //       return Container(
          //           alignment: Alignment.center,
          //           child: const CircularProgressIndicator());
          //     }
          //   },
          // )
        ],
      ),
    );
  }

  // void gettingvoice() async {
  //   try {
  //     if (!isListening) {
  //       var available = await speechToText.initialize();
  //       if (available) {
  //         isListening = true;
  //         speechToText.listen(
  //           onResult: (result) {
  //             setState(() {
  //               search.text = result.recognizedWords;
  //             });
  //           },
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     log("$e");
  //   }
  //   Future.delayed(const Duration(seconds: 5), () {
  //     setState(() {
  //       isListening = false;
  //       // clear();
  //     });
  //   });
}
// }
