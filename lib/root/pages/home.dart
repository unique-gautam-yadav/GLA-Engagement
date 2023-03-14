import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gla_engage/backend/models.dart';
import 'package:gla_engage/root/pages/posts_page.dart';

import '../../backend/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomePagePosts>? data;

  getData() async {
    List<HomePagePosts> temp = await Auth.getPosts();
    setState(() {
      data = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            data != null
                ? Column(
                    children: data!.map((e) {
                      return PostCard(
                          e: e.post!.toMap(),
                          profileData: e.profile!,
                          fromProfile: false);
                    }).toList(),
                  )
                : const SizedBox.shrink(),
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text("Logout")),
          ],
        ),
      ),
    );
    // bottomNavigationBar: NavBarView(),
    // );
  }
}
