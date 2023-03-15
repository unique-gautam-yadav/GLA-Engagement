import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gla_engage/backend/backend.dart';

import '../../backend/models.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.chatRoom,
      required this.targetUserMail,
      required this.targetUser});

  final ChatRoomModel chatRoom;
  final String targetUserMail;
  final ProfileModel targetUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgcontrol = TextEditingController();
  bool isTextFilled = false;

  @override
  void initState() {
    super.initState();
    msgcontrol.addListener(() {
      isTextFilled = msgcontrol.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        title: Expanded(
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: widget.targetUser.imgUrl != null
                    ? NetworkImage(widget.targetUser.imgUrl!)
                    : null,
                child: widget.targetUser.imgUrl == null
                    ? const Icon(Icons.person_3)
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.targetUser.name!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        widget.targetUser.mail!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: BackEnd.getChats(widget.chatRoom.chatroomid!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ChatModel chat = ChatModel.fromMap(
                                snapshot.data!.docs.elementAt(index).data());

                            bool self = chat.sender ==
                                FirebaseAuth.instance.currentUser!.email;

                            return BubbleSpecialThree(
                              text: "${chat.message}",
                              color: self
                                  ? const Color(0xFFE8E8EE)
                                  : Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.7),
                              tail: false,
                              isSender: self,
                            );
                          });
                    } else {
                      return const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("No messages yet!!"));
                    }
                  } else {
                    return const Center(
                        child: SpinKitCircle(color: Colors.green, size: 55));
                  }
                }),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TextFormField(
                    cursorColor: Colors.green,
                    autocorrect: true,
                    controller: msgcontrol,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 81, 187, 104)),
                      labelText: "enter message",
                      // suffixIcon: isTextFilled
                      //     ? IconButton(
                      //         onPressed: () async {
                      //           msgcontrol.clear();
                      //         },
                      //         icon: const Icon(
                      //           Icons.send,
                      //           color: Color.fromARGB(255, 83, 212, 88),
                      //         ),
                      //       )
                      //     : null,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      hintText: "Enter something to Chats ",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () async {
                    if (msgcontrol.text.trim().isNotEmpty) {
                      ChatModel chat = ChatModel(
                          message: msgcontrol.text.trim(),
                          sender: FirebaseAuth.instance.currentUser!.email,
                          timeStamp: DateTime.now());
                      await BackEnd.sendChat(widget.chatRoom.chatroomid!, chat);
                    }
                    msgcontrol.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Color.fromARGB(255, 83, 212, 88),
                  ),
                )
                // IconButton(
                //   color: const Color.fromARGB(255, 48, 220, 53),
                //   onPressed: () {},
                //   icon: const Icon(Icons.attach_file),
                // ),

                // const SizedBox(width: 4),
                // if(tcontroller.text!=null)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
