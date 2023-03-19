import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glaengage/backend/backend.dart';
import 'package:glaengage/root/pages/chat_screen.dart';
import 'package:glaengage/root/pages/public_profile.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
    List<ChatRoomModel> temp = await BackEnd.getRecentChat();
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
                    return RecentChatCard(
                        chatRoom: recent!.elementAt(index),
                        targetUserMail: targetUserMail);
                  },
                )
              : const Center(
                  child: Text("No recent chat!!"),
                )
          : Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.25),
              highlightColor: Colors.white.withOpacity(.6),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey.withOpacity(.9),
                            ),
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 15,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.6),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                height: 15,
                                width: MediaQuery.of(context).size.width - 100,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.6),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class RecentChatCard extends StatefulWidget {
  const RecentChatCard({
    super.key,
    required this.chatRoom,
    required this.targetUserMail,
  });

  final ChatRoomModel chatRoom;
  final String targetUserMail;

  @override
  State<RecentChatCard> createState() => _RecentChatCardState();
}

class _RecentChatCardState extends State<RecentChatCard> {
  ProfileModel? targetUser;
  getProfile() async {
    ProfileModel? temp = await Auth.getProfileByMail(widget.targetUserMail);
    setState(() {
      targetUser = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return targetUser != null
        ? ListTile(
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
                          borderRadius: BorderRadius.circular(12)),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * .7,
                        width: MediaQuery.of(context).size.width * .7,
                        child: targetUser!.imgUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  "${targetUser!.imgUrl}",
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Center(child: Text("No profile pic!!")),
                      ),
                    );
                  },
                );
              },
              child: CircleAvatar(
                  backgroundImage: targetUser!.imgUrl != null
                      ? NetworkImage(targetUser!.imgUrl!)
                      : null,
                  child: targetUser!.imgUrl == null
                      ? const Icon(Icons.person_3)
                      : null),
            ),
            title: Text("${targetUser!.name}"),
            subtitle: Text("${widget.chatRoom.lastmessage}"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      targetUser: targetUser!,
                      chatRoom: widget.chatRoom,
                      targetUserMail: widget.targetUserMail,
                    ),
                  ));
            },
          )
        : Container(
            margin: const EdgeInsets.all(10),
            child: Shimmer.fromColors(
              period: const Duration(seconds: 2),
              enabled: true,
              baseColor: Colors.grey.withOpacity(.25),
              highlightColor: Colors.white.withOpacity(.6),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.withOpacity(.9),
                    ),
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.6),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 15,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.6),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
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
                                searchResult!.elementAt(index).mail!);
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      targetUser:
                                          searchResult!.elementAt(index),
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
