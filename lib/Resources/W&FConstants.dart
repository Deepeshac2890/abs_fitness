/*
Created By: Deepesh Acharya
Maintained By: Deepesh Acharya
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Screens/WelcomeScreen.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

Future<void> logout(BuildContext context) async {
  FirebaseAuth fa = FirebaseAuth.instance;
  await fa.signOut();
  Navigator.popUntil(context, ModalRoute.withName(WelcomeScreen.id));
}

Widget loadingWidget() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

AppBar appBarWithLogOut(BuildContext context) {
  return AppBar(
    actions: [
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          logout(context);
        },
      ),
    ],
  );
}
