import 'package:flutter/cupertino.dart';

abstract class AdminDetailsPageEvent {}

class InitEvent extends AdminDetailsPageEvent {}

class LoadUIEvent extends AdminDetailsPageEvent {
  final BuildContext context;
  final String planName;

  LoadUIEvent(this.context, this.planName);
}

class CloseRequestEvent extends AdminDetailsPageEvent {
  final int index;
  final String planName;

  CloseRequestEvent(this.index, this.planName);
}
