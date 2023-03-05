import 'package:gla_engage/backend/models.dart';
import 'package:gla_engage/root/pages/auth/student_next.dart';
import 'package:validators/validators.dart' as dd;
import 'package:flutter/material.dart';
import 'package:gla_engage/backend/keywords.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.togglePages});

  final VoidCallback togglePages;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  String? userTpe;
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  navigateToNextStep() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (userTpe == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          content: Text("Please select user type"),
        ),
      );
    } else {
      if (formKey.currentState!.validate()) {
        if (userTpe == KeyWords.alumniUser) {
          Alumni model = Alumni(mail: mail.text);
        } else if (userTpe == KeyWords.studentUser) {
          Student model = Student(mail: mail.text);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentRegisterNextStep(
                    model: model, password: password.text),
              ));
        } else if (userTpe == KeyWords.teacherUser) {
          Teacher model = Teacher(mail: mail.text);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            showCloseIcon: true,
            content: Text("Check all required fields"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 85, bottom: 85),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                    child: Text(
                  "Logo Here!!",
                  style: TextStyle(color: Colors.white),
                )),
              ),
              const SizedBox(height: 35),
              Text("Sign Up to App",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 65),
              TextFormField(
                controller: mail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This filed is required";
                  } else if (!dd.isEmail(value)) {
                    return "Please enter valid mail";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: "Enter mail address",
                    labelText: "Mail",
                    prefixIcon: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  } else if (value.length < 6) {
                    return "Password must hava 6 chars";
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Enter password",
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This flield is required";
                  } else if (password.text != value) {
                    return "Password didn't match re-password";
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Enter password again",
                    labelText: "Re Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      top: 9.5,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(top: 8),
                        height: 178,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).iconTheme.color!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            RadioListTile(
                              title: const Text("Student"),
                              value: KeyWords.studentUser,
                              groupValue: userTpe,
                              onChanged: (value) {
                                FocusManager.instance.primaryFocus!.unfocus();
                                setState(() {
                                  userTpe = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("Teacher"),
                              value: KeyWords.teacherUser,
                              groupValue: userTpe,
                              onChanged: (value) {
                                FocusManager.instance.primaryFocus!.unfocus();
                                setState(() {
                                  userTpe = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("Alumni"),
                              value: KeyWords.alumniUser,
                              groupValue: userTpe,
                              onChanged: (value) {
                                FocusManager.instance.primaryFocus!.unfocus();
                                setState(() {
                                  userTpe = value.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: const Text(
                          "You are a",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    navigateToNextStep();
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  )),
              const Text("or"),
              InkWell(
                onTap: widget.togglePages,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: "Hava an account?",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                            text: " Log in",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    mail.dispose();
    password.dispose();
    super.dispose();
  }
}
