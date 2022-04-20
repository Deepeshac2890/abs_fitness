import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DashboardState extends Equatable {
  DashboardState init() {
    return DashboardState();
  }

  DashboardState clone() {
    return DashboardState();
  }

  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<Widget> loadedUIElements;

  DashboardLoaded(this.loadedUIElements);
  @override
  List<Object> get props => [loadedUIElements];
}

class AdminDashboardLoaded extends DashboardState {
  final List<Widget> loadedUIElements;

  AdminDashboardLoaded(this.loadedUIElements);
  @override
  List<Object> get props => [loadedUIElements];
}
