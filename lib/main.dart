import 'package:flutter/material.dart';
import 'package:todo_listapp/screens/Home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_Screen(),
    );
  }
}



// class routes {
//   static const String SplashScreen = 'splashScreen';
//   static const String LoginScreen = 'loginScreen';
//   static const String RegisterScreen = 'registerScreen';
//   static const String HomeScreen = 'homeScreen';
//   static const String CatagoryList = 'catagoryList';
//   static const String NoteScreen = 'noteScreen';
//   static const String CompletedNote = 'completedNote';

//   static Map<String, Widget Function(BuildContext)> MyRoutes() {
//     return {HomeScreen: (context) => Home_Screen()};
//   }
// }
