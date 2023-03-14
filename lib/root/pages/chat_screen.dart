import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.roomID});

  final String roomID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        title: Row(
          children: [
            const CircleAvatar(
              child: Icon(Icons.person_3),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  "Person Name",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  "data@gmail.com",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: const [],
      ),
    );
  }
}
