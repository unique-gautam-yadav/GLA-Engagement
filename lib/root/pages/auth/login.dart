import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glaengage/backend/auth.dart';
import 'package:validators/validators.dart' as validator;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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

  SendEmail() async {
    String username = 'adityachauhan9456923436@gmail.com';
    String password = 'ivxfgoragdskcghn';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Coding Beasts')
      ..recipients.add(mail.text)
      ..subject = 'Login Activity Recogniced '
      ..text =
          'We Have Noticed An Unusual Activity in Your Account There Is an Log in .\n So If You Have Not Log In Your Account then Please Contact Us .';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. + $e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    var connection = PersistentConnection(smtpServer);
    await connection.send(message);
    await connection.close();
  }

  login() async {
    bool toBeChanged = true;
    setState(() {
      processing = true;
      SendEmail();
    });
    if (formKey.currentState!.validate()) {
      String msg = await Auth.login(mail.text, password.text);
      if (msg == 'ok') {
        toBeChanged = false;
      } else if (context.mounted) {
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
    if (toBeChanged) {
      setState(() {
        processing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 85),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Image.asset("assets/images/logo.png"),
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
                      ],
                    ),
                  ),
                ),
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
