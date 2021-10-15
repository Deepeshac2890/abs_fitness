import 'package:abs_fitness/Screens/DashboardScreen.dart';
import 'package:abs_fitness/Screens/LoginScreen.dart';
import 'package:abs_fitness/Screens/RegistrationScreen.dart';
import 'package:abs_fitness/Screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Abs-Fitness",
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        DashboardScreen.id: (context) => DashboardScreen(),
      },
    );
  }
}
