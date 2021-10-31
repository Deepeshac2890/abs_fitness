import 'package:flutter/cupertino.dart';

class DashboardState {
  DashboardState init() {
    return DashboardState();
  }

  DashboardState clone() {
    return DashboardState();
  }
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<Widget> loadedUIElements;

  DashboardLoaded(this.loadedUIElements);
}

class AdminDashboardLoaded extends DashboardState {
  final List<Widget> loadedUIElements;

  AdminDashboardLoaded(this.loadedUIElements);
}
