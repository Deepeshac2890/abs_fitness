import 'dart:async';

import 'package:abs_fitness/Model/LoginModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LOGIN_EVENT_TYPE {
  LOGIN_USING_MAIL,
  SEND_RESET_LINK,
}

class LoginBloc {
  final FirebaseAuth fa = FirebaseAuth.instance;
  LoginEventModel lem;

  // 0-mail
  // 1-reset
  final _loginStreamController = StreamController<int>();
  StreamSink<int> get _loginSink => _loginStreamController.sink;
  Stream<int> get loginStream => _loginStreamController.stream;

  final _eventStreamController = StreamController<LoginEventModel>();
  StreamSink<LoginEventModel> get eventSink => _eventStreamController.sink;
  Stream<LoginEventModel> get _eventStream => _eventStreamController.stream;

  // This has to be done to prevent memory leak !!
  void dispose() {
    _eventStreamController.close();
    _loginStreamController.close();
  }

  LoginBloc() {
    _eventStream.listen((event) {
      if (event.eventType != null) {
        if (event.eventType == LOGIN_EVENT_TYPE.LOGIN_USING_MAIL.toString())
          triggerEvent(event.eventType, event.lm.emailID, event.lm.password);
        else if (event.eventType ==
            LOGIN_EVENT_TYPE.SEND_RESET_LINK.toString()) {
          triggerEvent(event.eventType, event.lm.emailID, event.lm.password);
        }
      }
    });
  }

  void triggerEvent(String type, String emailID, String password) {
    LoginModel lm =
        LoginModel(emailID: emailID, password: password, type: type.toString());
    lem = LoginEventModel(lm: lm, eventType: type.toString());
    if (type == LOGIN_EVENT_TYPE.LOGIN_USING_MAIL.toString()) {
      loginUsingEmail(lm.emailID, lm.password);
    } else if (type == LOGIN_EVENT_TYPE.SEND_RESET_LINK.toString()) {
      sendResetLink(lm.emailID);
    }
  }

  void loginUsingEmail(String emailID, String password) async {
    try {
      await fa.signInWithEmailAndPassword(email: emailID, password: password);
      _loginSink.add(0);
    } catch (e) {
      print(e);
      _loginSink.add(2);
      _loginSink.addError("Invalid Credentials!!! Login Failed");
    }
  }

  void sendResetLink(String emailID) async {
    try {
      await fa.sendPasswordResetEmail(email: emailID);
      _loginSink.add(1);
    } catch (e) {
      print(e);
      _loginSink.add(2);
      _loginSink.addError("Invalid Email ID !!!!");
    }
  }
}
