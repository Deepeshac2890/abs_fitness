import 'package:abs_fitness/Components/ReusablePaddingWidget.dart';
import 'package:abs_fitness/login/view.dart';
import 'package:abs_fitness/registration/view.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "WelcomeScreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset(
                      'assets/abs.gif',
                      height: 100.0,
                      width: 150.0,
                    ),
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Absolute-Fitness'],
                  textStyle: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Hero(
              tag: 'Login',
              child: Paddy(
                      op: () {
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                      textVal: 'Log In',
                      bColor: Colors.lightBlue)
                  .getPadding(),
            ),
            Hero(
              tag: 'Register',
              child: Paddy(
                      op: () {
                        Navigator.pushNamed(context, RegistrationPage.id);
                      },
                      textVal: 'Register',
                      bColor: Colors.blue)
                  .getPadding(),
            ),
          ],
        ),
      ),
    );
  }
}
