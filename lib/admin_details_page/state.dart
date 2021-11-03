import 'package:flutter/cupertino.dart';

class AdminDetailsPageState {
  AdminDetailsPageState init() {
    return AdminDetailsPageState();
  }

  AdminDetailsPageState clone() {
    return AdminDetailsPageState();
  }
}

class LoadingUI extends AdminDetailsPageState {}

class UILoaded extends AdminDetailsPageState {
  final List<Widget> loadedUIWidgets;

  UILoaded(this.loadedUIWidgets);
}
