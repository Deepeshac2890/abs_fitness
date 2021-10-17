import 'package:abs_fitness/Components/ReusablePaddingWidget.dart';
import 'package:abs_fitness/dashboard/view.dart';
import 'package:abs_fitness/login/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Constants.dart';
import 'bloc.dart';
import 'event.dart';

class LoginPage extends StatelessWidget {
  String emailId;
  String passwd;
  var forgotEmailController = TextEditingController();
  static final id = "LoginPage";
  LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (BuildContext context, state) {
        print(state.toString());
        if (state is LoginSuccess) {
          if (state.success) {
            Navigator.pushNamed(context, DashboardPage.id);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        } else if (state is ResetSuccess) {
          if (state.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'The Reset Link was sent successfully',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        }
      },
      builder: (BuildContext context, state) {
        if (state is InitEvent) {
          return loginInit(context);
        } else if (state is LoadingState)
          return loadingWidget();
        else
          return loginInit(context);
      },
    );
  }

  Widget loadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget loginInit(BuildContext context) {
    // bool isSpinning = false;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (BuildContext innerContext) {
          return Padding(
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
                            // Login Here
                            loginBloc.add(LoginUsingMailEvent(emailId, passwd));
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
                              // Do reset here
                              loginBloc.add(SendResetLinkEvent(email));
                              Navigator.pop(context);
                              forgotEmailController.clear();
                            },
                            child: Text(
                              "Request",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ).show();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
