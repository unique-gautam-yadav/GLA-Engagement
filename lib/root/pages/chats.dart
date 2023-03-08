// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:microphone/microphone.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController Textcontroller = TextEditingController();
  bool islistening = false;
  bool _isTextFilled = false;

  @override
  void initState() {
    super.initState();
    Textcontroller.addListener(() {
      setState(() {
        _isTextFilled = Textcontroller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    Textcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Post> _posts = [
      Post(str: 'Hello!', dt: DateTime.now()),
      Post(str: 'Hi there!', dt: DateTime.now()),
      Post(str: 'How are you?', dt: DateTime.now()),
      Post(str: 'I\'m doing well, thanks!', dt: DateTime.now()),
      Post(str: 'What have you been up to?', dt: DateTime.now()),
      Post(str: 'Just working on some projects.', dt: DateTime.now()),
    ];
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 169, 236, 160),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Appbarr(),
            Container(
              height: 60.0,
              child: Expanded(
                  child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final Post posts = _posts[index];
                    return Post(str: posts.str, dt: posts.dt);
                  },
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      height: MediaQuery.of(context).size.height * .1,
                      child: TextFormField(
                        cursorColor: Colors.green,
                        autocorrect: true,
                        controller: Textcontroller,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 81, 187, 104)),
                          labelText: "enter message",
                          suffixIcon: _isTextFilled
                              ? IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.green,
                                  ),
                                )
                              : null,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          hintText: "enter something to Chats someone",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 38, 194, 72),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      color: Color.fromARGB(255, 48, 220, 53),
                      onPressed: () {},
                      icon: Icon(Icons.attach_file),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(width: 5),
                    // if(tcontroller.text!=null)

                    AvatarGlow(
                      animate: islistening,
                      duration: Duration(seconds: 5),
                      glowColor: Colors.orange,
                      repeat: true,
                      repeatPauseDuration: Duration(seconds: 1),
                      endRadius: 25.0,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              islistening = true;
                            });
                          },
                          // onPressed: () {},
                          icon: Icon(
                            islistening ? Icons.mic : Icons.mic_none,
                            color: Colors.green,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Appbarr extends StatelessWidget {
  const Appbarr({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        color: Color.fromARGB(255, 102, 211, 107),
      ),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 20.0),
                Text(
                  "person name",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          PopupMenuButton<int>(
            onSelected: (value) {
              // if value 1 show dialog
              if (value == 1) {
                print("hello, i is clicked ");
                // if value 2 show dialog
              } else if (value == 2) {
                print("second is clicked");
              }
            },
            itemBuilder: (context) => [
              // popupmenu item 1
              const PopupMenuItem(value: 1, child: Text("Get The App")),
              // popupmenu item 2
              const PopupMenuItem(
                  value: 2,
                  // row has two child icon and text
                  child: Text("About")),
            ],
          ),
        ],
      ),
    );
  }
}

class Post extends StatelessWidget {
  const Post({
    Key? key,
    required this.str,
    required this.dt,
  }) : super(key: key);
  final String str;
  final DateTime dt;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      child: Column(
        children: [
          Text(str),
          Text(
            dt.toString(),
            style: TextStyle(fontSize: 10.0),
          )
        ],
      ),
    );
  }
}
