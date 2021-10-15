import 'package:abs_fitness/Bloc/LoginBloc.dart';
import 'package:abs_fitness/Components/ReusablePaddingWidget.dart';
import 'package:abs_fitness/Screens/DashboardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc lb = LoginBloc();
  bool isSpinning = false;
  String emailId;
  String passwd;
  var forgotEmailController = TextEditingController();
  bool sendLink = false;

  @override
  void dispose() {
    lb.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamBuilder(
      stream: lb.loginStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == 0) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Navigator.pushNamed(context, DashboardScreen.id),
            );
          }
        }
        print(snapshot.data);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Builder(
            builder: (BuildContext innerContext) {
              return ModalProgressHUD(
                inAsyncCall: isSpinning,
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
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
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
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                        child: TextField(
                          textAlign: TextAlign.center,
                          obscureText: true,
                          onChanged: (value) {
                            passwd = value;
                          },
                          decoration: kTextFieldDecoration,
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Hero(
                        tag: 'Login',
                        child: Paddy(
                                op: () async {
                                  lb.triggerEvent(
                                      LOGIN_EVENT_TYPE.LOGIN_USING_MAIL
                                          .toString(),
                                      emailId,
                                      passwd);
                                },
                                textVal: 'Login',
                                bColor: Colors.blue)
                            .getPadding(),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          child: Text('Forgot Password ?'),
                          onPressed: () {
                            // Implement Forgot Password Page
                            Alert(
                              context: context,
                              title: 'Forgot Password',
                              content: Column(
                                children: [
                                  GestureDetector(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.account_circle),
                                        labelText: 'Username',
                                      ),
                                      onChanged: (value) {
                                        // Do something
                                      },
                                      controller: forgotEmailController,
                                    ),
                                    onHorizontalDragDown: (dragDownDetails) {
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');
                                    },
                                  ),
                                ],
                              ),
                              buttons: [
                                DialogButton(
                                  onPressed: () async {
                                    var email = forgotEmailController.text;
                                    lb.triggerEvent(
                                        LOGIN_EVENT_TYPE.SEND_RESET_LINK
                                            .toString(),
                                        email,
                                        null);
                                    //TODO: Add the toast message to display link sent
                                    Navigator.pop(context);
                                    forgotEmailController.clear();
                                  },
                                  child: Text(
                                    "Request",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            ).show();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
