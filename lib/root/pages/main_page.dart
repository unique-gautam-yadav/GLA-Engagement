import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glaengage/backend/auth.dart';
import 'package:glaengage/backend/providers.dart';
import 'package:glaengage/root/pages/add_post.dart';
import 'package:glaengage/root/pages/chats.dart';
import 'package:glaengage/root/pages/home.dart';
import 'package:glaengage/root/pages/work.dart';
import 'package:glaengage/root/pages/public_profile.dart';
import 'package:glaengage/root/pages/search.dart';
import 'package:glaengage/root/pages/self_profile.dart';
import 'package:provider/provider.dart';

import 'hire.dart';

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

  Color selectedIconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: curPageIndex == 0
          ? AppBar(
              title: const Text(
                "ᏀᏞᎪХᎽ",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            )
          : null,
      drawer: Drawer(
          child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20)),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
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
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PublicProfile(
                                    email: FirebaseAuth
                                        .instance.currentUser!.email!),
                              ));
                        },
                        child: const Text("View Profile"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const work();
                },
              ));
            },
            leading: const Icon(Icons.attach_money_outlined),
            title: const Text("Work"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const hire();
                },
              ));
            },
            leading: const Icon(Icons.handshake),
            title: const Text("Hire"),
          ),
          ListTile(
            onTap: () {
              Auth.logOut();
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
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(.1)),
                  color: Colors.indigo.shade300,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(25))),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
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
                              ? selectedIconColor
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
                              ? selectedIconColor
                              : Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(25),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(200))),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.indigoAccent.shade200)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const NewPostPage(),
                                  ));
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
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
                              ? selectedIconColor
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
                              ? selectedIconColor
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
