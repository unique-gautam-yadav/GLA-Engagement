import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.togglePages});

  final VoidCallback togglePages;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 85, bottom: 85),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text("Sign In to App",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 65),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Enter mail address",
                    labelText: "Mail",
                    prefixIcon: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(height: 20),
              TextFormField(
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
                  onPressed: () {},
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
          )),
    );
  }
}
