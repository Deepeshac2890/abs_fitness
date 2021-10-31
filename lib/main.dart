import 'package:abs_fitness/Screens/WelcomeScreen.dart';
import 'package:abs_fitness/admin_details_page/view.dart';
import 'package:abs_fitness/dashboard/view.dart';
import 'package:abs_fitness/details_page/view.dart';
import 'package:abs_fitness/login/view.dart';
import 'package:abs_fitness/profile/view.dart';
import 'package:abs_fitness/registration/view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        DashboardPage.id: (context) => DashboardPage(),
        LoginPage.id: (context) => LoginPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        DetailsPage.id: (context) => DetailsPage(
              planName: null,
            ),
        AdminDetailsPage.id: (context) => AdminDetailsPage(
              planName: null,
            ),
        ProfilePage.id: (context) => ProfilePage(),
      },
    );
  }
}
