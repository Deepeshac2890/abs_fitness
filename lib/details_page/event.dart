import 'package:flutter/cupertino.dart';

abstract class DetailsPageEvent {}

class InitEvent extends DetailsPageEvent {}

class LoadPageEvent extends DetailsPageEvent {
  final String planName;
  final BuildContext context;

  LoadPageEvent(this.planName, this.context);
}

class LogoutDetailsPageEvent extends DetailsPageEvent {
  final BuildContext context;

  LogoutDetailsPageEvent(this.context);
}
