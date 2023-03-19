import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../backend/providers.dart';

class hire extends StatefulWidget {
  const hire({super.key});

  @override
  State<hire> createState() => _hireState();
}

class _hireState extends State<hire> {
  bool processing = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController skill = TextEditingController();
  TextEditingController decp = TextEditingController();
  TextEditingController package = TextEditingController();
  TextEditingController Duration = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hire "),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Welcome,",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 12),
                    child: Text(
                      "${context.watch<UserProvider>().getProfile!.name}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width - 20,
                child: SvgPicture.asset(
                  "assets/images/hire.svg",
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is reuired";
                  } else {
                    return null;
                  }
                },
                controller: skill,
                decoration: InputDecoration(
                    hintText: "Enter Skill You Are Looking For",
                    labelText: "Skill",
                    // prefixIcon: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is reuired";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                controller: Duration,
                decoration: InputDecoration(
                    hintText: "Enter Duration in Months",
                    labelText: "Duration",
                    // prefixIcon: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is reuired";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                controller: package,
                decoration: InputDecoration(
                    hintText: "Enter Total Package ",
                    labelText: "Package",
                    // prefixIcon: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is reuired";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                controller: decp,
                decoration: InputDecoration(
                    hintText: "Enter Detailed description of Job ",
                    labelText: "Description of Job",
                    // prefixIcon: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
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
                            "Hire ",
                            style: TextStyle(color: Colors.white),
                          )),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      )),
    );
  }
}
