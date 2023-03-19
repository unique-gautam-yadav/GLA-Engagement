import 'package:flutter/material.dart';
import 'package:glaengage/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    if (mounted) {
      if (context.mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.topRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
          ],
        )),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 500.0,
              width: 300.0,
              alignment: Alignment.center,
            )
          ],
        ),
      ),
    );
  }
}
