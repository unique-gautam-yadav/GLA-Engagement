import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gla_engage/backend/auth.dart';
import 'package:validators/validators.dart' as validator;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.togglePages});

  final VoidCallback togglePages;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  bool processing = false;

  login() async {
    setState(() {
      processing = true;
    });
    if (formKey.currentState!.validate()) {
      String msg = await Auth.login(mail.text, password.text);
      log(msg);
      if (context.mounted) {
        if (msg == "wrong-password") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Incorrect Password"),
            showCloseIcon: true,
          ));
        } else if (msg == "user-not-found") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("No user found"),
            showCloseIcon: true,
          ));
        } else if (msg == "user-disabled") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("This user is disabled"),
            showCloseIcon: true,
          ));
        } else if (msg == "invalid-email") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Invalid mail"),
            showCloseIcon: true,
          ));
        } else if (msg == "ok") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Loggin in"),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Some thing went wrong"),
            showCloseIcon: true,
          ));
        }
      }
    }
    setState(() {
      processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 85),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                      child: Text(
                    "Logo Here!!",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                const SizedBox(height: 35),
                Text("Sign In to App",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 65),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is reuired";
                    } else if (!validator.isEmail(value)) {
                      return "Invalid mail";
                    } else {
                      return null;
                    }
                  },
                  controller: mail,
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
                      return "Invalid password";
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
                const SizedBox(height: 50),
                SizedBox(
                  width: 411,
                  height: 42,
                  child: ElevatedButton(
                      onPressed: () {
                        if (!processing) {
                          login();
                        }
                      },
                      child: processing
                          ? const SpinKitFadingCircle(
                              color: Colors.white, size: 20)
                          : const Text(
                              "Sign In",
                              style: TextStyle(color: Colors.white),
                            )),
                ),
                const SizedBox(height: 4),
                const Text("or"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Don't hava an account?"),
                    InkWell(
                      onTap: widget.togglePages,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
