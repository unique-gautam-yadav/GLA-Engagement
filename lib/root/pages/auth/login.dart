import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;

import 'package:gla_engage/root/pages/main_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 85, bottom: 85),
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
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavBarView(),
                          ));
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    )),
                const Text("or"),
                InkWell(
                  onTap: widget.togglePages,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't hava an account?",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                              text: " Register",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
