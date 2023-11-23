import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_listapp/screens/Home_screen.dart';
import 'package:todo_listapp/loginTask/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      var prefs = await SharedPreferences.getInstance();
      bool? Checklogin = prefs.getBool(ComponentClass.Login_pref_key);

      Widget navigateTo = LoginScreen();
      if (Checklogin != null && Checklogin) {
        navigateTo = Home_Screen();
      }
      // if (Checklogin == null) {
      //   navigateTo = LoginScreen();
      // } else {
      //   if (Checklogin) {
      //     navigateTo = HomeScreen();
      //   } else {
      //     navigateTo = LoginScreen();
      //   }
      // }
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return navigateTo;
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uicolors.appblue.withAlpha(205),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Lottie.asset('assets/lottie/splashani.json'),
          Text(
            'Welcome TO',
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: uicolors.textfildlabel),
          ),
          Text(
            'TO-DO APP',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: uicolors.textfildlabel),
          )
        ]),
      ),
    );
  }
}
