class LoginModel {
  final String emailID;
  final String password;
  final String type;

  LoginModel({this.emailID, this.password, this.type});
}

class LoginEventModel {
  final String eventType;
  final LoginModel lm;

  LoginEventModel({this.eventType, this.lm});
}
