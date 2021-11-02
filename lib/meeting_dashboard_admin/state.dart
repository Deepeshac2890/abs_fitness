import 'package:flutter/cupertino.dart';

class MeetingDashboardAdminState {
  MeetingDashboardAdminState init() {
    return MeetingDashboardAdminState();
  }

  MeetingDashboardAdminState clone() {
    return MeetingDashboardAdminState();
  }
}

class LoadingUI extends MeetingDashboardAdminState {}

class UILoaded extends MeetingDashboardAdminState {
  final List<Widget> uiElements;

  UILoaded(this.uiElements);
}
