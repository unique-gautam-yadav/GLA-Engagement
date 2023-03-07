import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

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
    return Container(
      color: Color.fromARGB(255, 169, 236, 160),
      child: Scaffold(
        appBar: AppBar(
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(30),
          //   ),
          // ),
          title: Text("NAME"),
          backgroundColor: Color.fromARGB(255, 40, 202, 124),
          leading: Icon(Icons.person_2),
          actions: [
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
              offset: Offset(0, 100),
              // color: Colors.grey,
              elevation: 2,
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: SingleChildScrollView()),
            Expanded(
              child: Row(
                children: [
                  
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    
                    child: TextFormField(
                      cursorColor: Colors.green,
                      autocorrect: true,
                      controller: Textcontroller,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                          suffixIcon: _isTextFilled
                              ? IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.send, color: Colors.green,),
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
            )
          ],
        ),
      ),
    );
  }
}
