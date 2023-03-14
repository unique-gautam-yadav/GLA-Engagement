import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gla_engage/backend/providers.dart';
import 'package:gla_engage/root/pages/add_post.dart';
import 'package:gla_engage/root/pages/chats.dart';
import 'package:gla_engage/root/pages/home.dart';
import 'package:gla_engage/root/pages/search.dart';
import 'package:gla_engage/root/pages/self_profile.dart';
import 'package:provider/provider.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({super.key});

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  List<Widget> pages = const [
    HomePage(),
    Chat(),
    SearchPage(),
    SelfProfile(),
  ];

  int curPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: curPageIndex == 0
          ? AppBar(
              title: const Text("Sdfklj"),
            )
          : null,
      drawer: Drawer(
          child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
                color: Colors.green.shade50,
                boxShadow: const [
                  BoxShadow(blurRadius: 3, color: Colors.white),
                  BoxShadow(
                      blurRadius: 5, color: Colors.grey, offset: Offset(0, 3))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                      backgroundImage: context
                                  .watch<UserProvider>()
                                  .getProfile!
                                  .imgUrl !=
                              null
                          ? NetworkImage(
                              context.watch<UserProvider>().getProfile!.imgUrl!,
                              scale: 1)
                          : null,
                      child: context.watch<UserProvider>().getProfile!.imgUrl ==
                              null
                          ? const Icon(Icons.person_3)
                          : null),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${context.watch<UserProvider>().getProfile!.name}"),
                      Text("${context.watch<UserProvider>().getProfile!.mail}"),
                    ],
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            leading: const Icon(Icons.logout),
            title: const Text("Log Out"),
          ),
        ],
      )),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [pages[curPageIndex], const SizedBox(height: 85)],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 12,
            right: 12,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green.shade100),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        colorBrightness: Brightness.dark,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () {
                          setState(() {
                            if (curPageIndex != 0) {
                              curPageIndex = 0;
                            }
                          });
                        },
                        child: Icon(
                          Icons.home_filled,
                          color: curPageIndex == 0
                              ? Colors.green.shade900
                              : Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // setState(() {
                          //   if (curPageIndex != 1) {
                          //     curPageIndex = 1;
                          //   }
                          // });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Chat()));
                        },
                        icon: Icon(
                          Icons.chat_rounded,
                          color: curPageIndex == 1
                              ? Colors.green.shade900
                              : Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NewPostPage(),
                                  ));
                            },
                            icon: const Icon(Icons.add)),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (curPageIndex != 2) {
                              curPageIndex = 2;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.search_rounded,
                          color: curPageIndex == 2
                              ? Colors.green.shade900
                              : Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (curPageIndex != 3) {
                              curPageIndex = 3;
                            }
                          });
                        },
                        icon: Icon(
                          CupertinoIcons.person_alt_circle,
                          color: curPageIndex == 3
                              ? Colors.green.shade900
                              : Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
