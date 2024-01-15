import 'dart:async';
import 'package:blogify/screens/home_screen.dart';
import 'package:blogify/screens/option_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    final user = auth.currentUser;
    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OptionScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image(
              image: const AssetImage(
                "assets/images/logo.png",
              ),
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width * .6,
            ),
          ),
          const Text(
            "Blogify!",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),
          )
        ],
      ),
    );
  }
}
