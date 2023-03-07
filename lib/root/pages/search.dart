import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gla_engage/root/pages/self_profile/Student_Profile.dart';
import 'package:speech_to_text/speech_to_text.dart';
=======
import 'package:speech_to_text/speech_to_text.dart' as stt;
>>>>>>> c21fd179b916f51faf2a178ea011b2d0c1225691

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController name = TextEditingController();
  String? text;
  @override
  void clear() {
    name.clear();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Row(
        children: [
          Avatar(),
          Container(
            width: MediaQuery.of(context).size.width - 120,
            height: 45,
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search Name or Post ",
                labelText: "$text",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(width: 0.5)),
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
                      clear();
                    });
                  },
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                //     _buildVoiceInput(
                // onPressed: _speechRecognitionAvailable && !_isListening
                //     ? () => start()
                //     : () => stop(),
                // label: _isListening ? 'Listening...' : '',
                // ),
              },
              icon: Icon(
                Icons.mic,
                size: 30,
                color: Colors.grey.shade600,
              ))
        ],
      ),
    );
  }

  Widget Avatar() {
    String img =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=MnwxfDB8MXxyYW5kb218MHx8cHJvZmlsZXx8fHx8fDE2NzgwNTEwNjM&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1600';

    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: NetworkImage('$img'),
        ),
      ),
    );
  }

  Future toggelRecording() => Speech.toggelRecording(
      onResult: (text) => setState(() => this.text = text));
}

class Speech {
  static final speech = SpeechToText();

  static Future<bool> toggelRecording({
    required Function(String text) onResult,
  }) async {
    final isAvailable = await speech.initialize();
    if (isAvailable) {
      speech.listen(onResult: (value) => onResult(value.recognizedWords));
    }
    return isAvailable;
  }
}

// USe this code for speech to text convert
// final stt.SpeechToText _speech = stt.SpeechToText();
//
// void startListening() {
//   _speech.listen(
//     onResult: (result) => print('Text: ${result.recognizedWords}'),
//     listenFor: Duration(minutes: 1),
//   );
// }
//
// void stopListening() {
//   _speech.stop();
// }