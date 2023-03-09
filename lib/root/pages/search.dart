import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'self_profile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SpeechToText speechToText = SpeechToText();
  TextEditingController name = TextEditingController();
  var isListening = false;
  @override

  //  ------------------------------------------------------
  requestMicrophonePermission() async {
    bool MicPermission = await Permission.microphone.isGranted;
    if (!MicPermission) {
      PermissionStatus t = await Permission.microphone.request();
      MicPermission = t.isGranted;
    } else {
      print("Your Already Have Permission");
    }
  }
  // ---------------------------------------------------------

  void clear() {
    name.clear();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              Avatar(),
              Container(
                width: MediaQuery.of(context).size.width - 120,
                height: 45,
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 15.0),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search Name or Post ",
                    labelText: "Search...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0.5)),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.grey.shade400,
                    ),
                    suffixIcon: IconButton(
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
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isListening ? Icons.mic : Icons.mic_none_outlined,
                  size: 30,
                  color: Colors.grey.shade600,
                ),
                onPressed: () {
                  gettingvoice();
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      Future.delayed(const Duration(seconds: 5), () {
                        Navigator.of(context).pop(true);
                      });
                      return AlertDialog(
                        alignment: Alignment.center,
                        content: Container(
                          height: 250,
                          width: 100,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              AvatarGlow(
                                endRadius: 75.0,
                                animate: isListening,
                                duration: const Duration(milliseconds: 2000),
                                glowColor: Colors.green.shade300,
                                repeat: true,
                                showTwoGlows: true,
                                repeatPauseDuration:
                                    const Duration(milliseconds: 100),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.mic_none_outlined,
                                      size: 50,
                                    )),
                              ),
                              const Text(
                                "Listening...",
                                style: TextStyle(),
                              )
                            ],
                          ),
                        ),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          //  Column .................
        ],
      ),
    );
  }

  void gettingvoice() async {
    try {
      if (!isListening) {
        var available = await speechToText.initialize();
        if (available) {
          isListening = true;
          speechToText.listen(
            onResult: (result) {
              setState(() {
                name.text = result.recognizedWords;
              });
            },
          );
        }
      }
      ;
    } catch (e) {
      print(e);
    }
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isListening = false;
        // clear();
      });
    });
  }

  Widget Avatar() {
    String img =
        "https://images.unsplash.com/photo-1480455624313-e29b44bbfde1?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=MnwxfDB8MXxyYW5kb218MHx8cHJvZmlsZT9ib3l8fHx8fHwxNjc4MjY4OTA3&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1600";
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SelfProfile()));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage('$img'),
        ),
      ),
    );
  }
}
