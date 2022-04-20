import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  LoginState init() {
    return LoginState();
  }

  LoginState clone() {
    return LoginState();
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final bool success;
  final String error;

  LoginSuccess(this.success, this.error);

  @override
  // TODO: implement props
  List<Object> get props => [success, error];
}

class ResetSuccess extends LoginState {
  final bool success;
  final String error;

  ResetSuccess(this.success, this.error);
  @override
  // TODO: implement props
  List<Object> get props => [success, error];
}

class LoadingState extends LoginState {}
