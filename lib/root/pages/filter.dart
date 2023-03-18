// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../backend/keywords.dart';

class filter extends StatefulWidget {
  const filter({
    super.key,
  });

  @override
  State<filter> createState() => _filterState();
}

class _filterState extends State<filter> {
  bool errorAt0 = false;
  bool errorAt1 = false;
  bool errorAt2 = false;
  String? userType;

  UserBanner() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: 7,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Text(
                    "Student",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: KeyWords.studentUser,
                      groupValue: userType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          userType = value.toString();
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Text(
                    "Teacher",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: KeyWords.teacherUser,
                      groupValue: userType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          userType = value.toString();
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Text(
                    "Alumni",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: KeyWords.alumniUser,
                      groupValue: userType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          userType = value.toString();
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: IconButton(
                    icon: Icon(CupertinoIcons.back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    "Filter",
                    style: TextStyle(fontSize: 25, color: Colors.grey.shade700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 13),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            fontSize: 22, color: Colors.grey.shade700),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "User Type",
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: SizedBox(
                    width: 125,
                    child: MaterialButton(
                      onPressed: () {
                        UserBanner();
                      },
                      child: Row(
                        children: [
                          userType == null
                              ? Text(
                                  "View All",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                )
                              : Text(
                                  "$userType",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Icon(CupertinoIcons.arrow_right),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
