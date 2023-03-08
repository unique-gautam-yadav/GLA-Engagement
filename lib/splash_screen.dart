import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(25)),
            child: const Center(
                child: Text(
              "Log Here!!",
              style: TextStyle(color: Colors.white),
            )),
          ),
          const SizedBox(height: 100),
          // SizedBox(
          //   height: 200,
          //   child: Lottie.asset("assets/lotties/loading.json"),
          // )
          SpinKitWave(
            color: Theme.of(context).primaryColor,
            size: 30,
          )
        ],
      ),
    );
  }
}
