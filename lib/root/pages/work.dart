import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glaengage/backend/providers.dart';
import 'package:glaengage/root/pages/public_profile.dart';
import 'package:provider/provider.dart';

import '../../backend/models.dart';

class work extends StatefulWidget {
  const work({super.key});

  @override
  State<work> createState() => _workState();
}

class _workState extends State<work> {
  @override
  TextEditingController search = TextEditingController();
  bool showClear = false;
  clear() {
    search.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Work"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PublicProfile(
                                    email: FirebaseAuth
                                        .instance.currentUser!.email!,
                                  )));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                            '${context.watch<UserProvider>().getProfile!.imgUrl}'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width - 120,
                    child: TextFormField(
                      controller: search,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            showClear = true;
                          });
                        } else {
                          setState(() {
                            showClear = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(15.0),
                        border: const UnderlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search...",
                        suffixIcon: search.text.isNotEmpty
                            ? IconButton(
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
                              )
                            : null,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {},
                      icon: Icon(
                        Icons.search_rounded,
                        size: 30,
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
