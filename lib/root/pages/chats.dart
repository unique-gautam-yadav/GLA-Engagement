import 'package:flutter/material.dart';
import 'package:microphone/microphone.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController Textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(30),
        //   ),
        // ),
        title: Text("NAME"),
        backgroundColor: Color.fromARGB(255, 40, 202, 124),
        leading: CircleAvatar(child: Icon(Icons.person_2)),
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
            color: Colors.grey,
            elevation: 2,
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SingleChildScrollView(),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 40, 202, 124),
                foregroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.attach_file),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: TextFormField(
                  autocorrect: true,
                  controller: Textcontroller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      hintText: "enter something to chat someone",
                      hoverColor: Colors.green),
                  validator: (value) {
                    if (true) {
                      setState(() {});
                    }
                  },
                ),
              ),
              SizedBox(width: 5),
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 40, 202, 124),
                foregroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_voice),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
