// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../backend/keywords.dart';

class filter extends StatefulWidget {
  const filter({
    super.key,
  });

  @override
  State<filter> createState() => _filterState();
}

class _filterState extends State<filter> {
  String? userType;
  String? branchType;
  String? skillType;
  String? courseType;
  bool processing = false;

  initState() {
    super.initState();
    setState(() {});
  }

  clear() {
    // userType = " ";
    // branchType = null;
    // courseType = null;
    // skillType = null;
    // String? userType;
  }

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
                    style: TextStyle(fontSize: 22),
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
                    style: TextStyle(fontSize: 22),
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
                    style: TextStyle(fontSize: 22),
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
  BranchBanner() {
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
                    "CS",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "CS",
                      groupValue: branchType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          branchType = value.toString();
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
                    "EC",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "EC",
                      groupValue: branchType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          branchType = value.toString();
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
                    "ME",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "ME",
                      groupValue: branchType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          branchType = value.toString();
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
                    "CE ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "CE ",
                      groupValue: branchType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          branchType = value.toString();
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
                    "EE",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "EE",
                      groupValue: branchType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          branchType = value.toString();
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

  CourseBanner() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
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
                      "B.Tech",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Radio(
                        value: "B.Tech",
                        groupValue: courseType,
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            courseType = value.toString();
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
                      "Diploma",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Radio(
                        value: "Diploma",
                        groupValue: courseType,
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            courseType = value.toString();
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
                      "PHD",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Radio(
                        value: "PHD",
                        groupValue: courseType,
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            courseType = value.toString();
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
                      "B.Com",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Radio(
                        value: "B.Com",
                        groupValue: courseType,
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            courseType = value.toString();
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
                      "BCA",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Radio(
                        value: "BCA",
                        groupValue: courseType,
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            courseType = value.toString();
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
                      "B.Sc",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Radio(
                        value: "B.Sc",
                        groupValue: courseType,
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            courseType = value.toString();
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
                      "M.Tech",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Radio(
                        value: "M.Tech",
                        groupValue: courseType,
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            courseType = value.toString();
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
                      "B.Pharma",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Radio(
                        value: "B.Pharma",
                        groupValue: courseType,
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            courseType = value.toString();
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
                      "LLB",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Radio(
                        value: "LLB",
                        groupValue: courseType,
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            courseType = value.toString();
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
                      "D.Pharma",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Radio(
                        value: "D.Pharma",
                        groupValue: courseType,
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            courseType = value.toString();
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
                      "MCA",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Radio(
                        value: "MCA",
                        groupValue: courseType,
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {
                            courseType = value.toString();
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  skillBanner() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
              child: Column(children: [
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
                    "Java",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "Java",
                      groupValue: skillType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          skillType = value.toString();
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
                    "Flutter",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "Flutter",
                      groupValue: skillType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          skillType = value.toString();
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
                    "Python",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "Python",
                      groupValue: skillType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          skillType = value.toString();
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
                    "C",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "C",
                      groupValue: skillType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          skillType = value.toString();
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
                    "Ruby",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "Ruby",
                      groupValue: skillType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          skillType = value.toString();
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
                    "C++",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "C++",
                      groupValue: skillType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          skillType = value.toString();
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
                    "React",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 240,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Radio(
                      value: "React",
                      groupValue: skillType,
                      onChanged: (value) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        setState(() {
                          skillType = value.toString();
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ]));
        });
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
                      onPressed: () {
                        clear();
                      },
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
                    style: TextStyle(fontSize: 20),
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
                          userType == null || userType == " "
                              ? Text(
                                  "View All",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                )
                              : Text(
                                  "$userType",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: userType == null
                                ? Icon(CupertinoIcons.arrow_right)
                                : Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Icon(CupertinoIcons
                                        .arrow_right_arrow_left_circle_fill),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Branch ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: SizedBox(
                    width: 125,
                    child: MaterialButton(
                      onPressed: () {
                        BranchBanner();
                      },
                      child: Row(
                        children: [
                          branchType == null
                              ? Text(
                                  "View All",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                )
                              : Text(
                                  "$branchType",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: branchType == null
                                ? Icon(CupertinoIcons.arrow_right)
                                : Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Icon(CupertinoIcons
                                        .arrow_right_arrow_left_circle_fill),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Course ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: SizedBox(
                    width: 125,
                    child: MaterialButton(
                      onPressed: () {
                        CourseBanner();
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            courseType == null
                                ? Text(
                                    "View All",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  )
                                : Text(
                                    "$courseType",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: courseType == null
                                  ? Icon(CupertinoIcons.arrow_right)
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Icon(CupertinoIcons
                                          .arrow_right_arrow_left_circle_fill),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Skill ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: SizedBox(
                    width: 125,
                    child: MaterialButton(
                      onPressed: () {
                        skillBanner();
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            skillType == null
                                ? Text(
                                    "View All",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  )
                                : Text(
                                    "$skillType",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: skillType == null
                                  ? Icon(CupertinoIcons.arrow_right)
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Icon(CupertinoIcons
                                          .arrow_right_arrow_left_circle_fill),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 400,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 411,
                height: 42,
                child: ElevatedButton(
                    onPressed: () {
                      if (!processing) {}
                    },
                    child: processing
                        ? const SpinKitFadingCircle(
                            color: Colors.white, size: 20)
                        : const Text(
                            "Search",
                            style: TextStyle(color: Colors.white),
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
