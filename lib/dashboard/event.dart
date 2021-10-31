import 'package:flutter/material.dart';

abstract class DashboardEvent {}

class InitEvent extends DashboardEvent {}

class CheckAdmin extends DashboardEvent {
  final BuildContext context;

  CheckAdmin(this.context);
}
