import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("Third Page"),
      ],
    );
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