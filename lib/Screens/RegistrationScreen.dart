import 'package:abs_fitness/Bloc/RegistrationBloc.dart';
import 'package:abs_fitness/Components/ReusablePaddingWidget.dart';
import 'package:abs_fitness/Screens/WelcomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../Constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'Registration_Screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String emailId;
  String password;
  String fName;
  RegistrationBloc rb = RegistrationBloc();
  // String gender; Implement the gender Radio Buttons Later
  bool showSpinner = false;
  String phoneNumber;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset(
                      'assets/abs.gif',
                      height: 200.0,
                      width: 200.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              GestureDetector(
                onHorizontalDragDown: (dragDownDetails) {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    fName = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter Your Full Name',
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              GestureDetector(
                onHorizontalDragDown: (dragDownDetails) {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    emailId = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter Your Email',
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              GestureDetector(
                onHorizontalDragDown: (dragDownDetails) {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter Your Phone Number',
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              GestureDetector(
                onHorizontalDragDown: (dragDownDetails) {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
                child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration,
                ),
              ),
              SizedBox(height: 24),
              Flexible(
                child: Hero(
                  tag: 'Register',
                  child: Paddy(
                          op: () async {
                            bool isRegistered = await rb.register(
                                emailId, password, fName, phoneNumber);
                            if (isRegistered) {
                              Navigator.popAndPushNamed(
                                  context, WelcomeScreen.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Registration was successful',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            } else {
                              //TODO: Add why unsuccessful
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Registration was unsuccessful',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }
                          },
                          textVal: 'Register',
                          bColor: Colors.blue)
                      .getPadding(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
