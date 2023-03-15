import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gla_engage/backend/backend.dart';
import 'package:gla_engage/root/pages/chat_screen.dart';
import 'package:gla_engage/root/pages/public_profile.dart';
import 'package:provider/provider.dart';

import '../../backend/auth.dart';
import '../../backend/models.dart';
import '../../backend/providers.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<ChatRoomModel>? recent;

  getRecentChats() async {
    List<ChatRoomModel> temp = await BackEnd.getRecentChats();
    setState(() {
      recent = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getRecentChats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Recent chats")),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchAndChat(),
                  ));
            },
            icon: const Icon(Icons.add),
            label: const Text("New Chat")),
        body: recent != null
            ? recent!.isNotEmpty
                ? ListView.builder(
                    itemCount: recent!.length,
                    itemBuilder: (context, index) {
                      String targetUserMail =
                          recent!.elementAt(index).users![0] ==
                                  FirebaseAuth.instance.currentUser!.email
                              ? recent!.elementAt(index).users![1]
                              : recent!.elementAt(index).users![0];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    chatRoom: recent!.elementAt(index),
                                    targetUserMail: targetUserMail),
                              ));
                        },
                        title: Text(targetUserMail),
                      );
                    },
                  )
                : const Center(
                    child: Text("No recent chat!!"),
                  )
            : const Center(
                child: SpinKitCircle(color: Colors.green, size: 55),
              ));
  }
}

class SearchAndChat extends StatefulWidget {
  const SearchAndChat({super.key});

  @override
  State<SearchAndChat> createState() => _SearchAndChatState();
}

class _SearchAndChatState extends State<SearchAndChat> {
  TextEditingController search = TextEditingController();
  bool showClear = false;
  List<ProfileModel>? searchResult;
  clear() {
    search.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(),
              ),
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
                      Expanded(
                        // width: MediaQuery.of(context).size.width - 120,
                        // height: 45,
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
                            focusColor: Colors.green,
                            hoverColor: Colors.amber,
                            contentPadding: const EdgeInsets.all(15.0),
                            border: InputBorder.none,
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
                    ],
                  ),
                ],
              ),
            ),
            searchResult != null
                ? Expanded(
                    // height: 500,
                    // width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: searchResult!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: MaterialButton(
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            minWidth: 0,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .7,
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      child: searchResult!
                                                  .elementAt(index)
                                                  .imgUrl !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                "${searchResult!.elementAt(index).imgUrl}",
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : const Center(
                                              child: Text("No profile pic!!")),
                                    ),
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                                backgroundImage: searchResult!
                                            .elementAt(index)
                                            .imgUrl !=
                                        null
                                    ? NetworkImage(
                                        searchResult!.elementAt(index).imgUrl!)
                                    : null,
                                child: searchResult!.elementAt(index).imgUrl ==
                                        null
                                    ? const Icon(Icons.person_3)
                                    : null),
                          ),
                          title: Text("${searchResult!.elementAt(index).name}"),
                          subtitle: Text(
                              "${searchResult!.elementAt(index).type!.toUpperCase()} ${searchResult!.elementAt(index).course} (${searchResult!.elementAt(index).branch})"),
                          onTap: () async {
                            ChatRoomModel c = await BackEnd.getChatRoom(
                                searchResult!.elementAt(index));
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      chatRoom: c,
                                      targetUserMail:
                                          searchResult!.elementAt(index).mail!),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
