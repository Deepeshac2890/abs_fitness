import 'package:flutter/cupertino.dart';

abstract class MeetingDashboardAdminEvent {}

class InitEvent extends MeetingDashboardAdminEvent {}

class LoadMeetingDashboardEvent extends MeetingDashboardAdminEvent {
  final BuildContext context;

  LoadMeetingDashboardEvent(this.context);
}
