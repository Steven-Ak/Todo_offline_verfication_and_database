import 'package:flutter/material.dart';
import 'login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void navToNextScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2),() {
    Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) => const LoginScreen())
    );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    navToNextScreen(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash.png"),
          fit: BoxFit.cover)
        )
      ),
    );
  }
}
