import 'package:flutter/cupertino.dart';

abstract class DetailsPageEvent {}

class InitEvent extends DetailsPageEvent {}

class LoadPageEvent extends DetailsPageEvent {
  final String planName;
  final BuildContext context;

  LoadPageEvent(this.planName, this.context);
}
