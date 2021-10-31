import 'package:flutter/material.dart';

class DetailsPageState {
  DetailsPageState init() {
    return DetailsPageState();
  }

  DetailsPageState clone() {
    return DetailsPageState();
  }
}

class LoadedPageState extends DetailsPageState {
  final Widget detailsWidget;

  LoadedPageState(this.detailsWidget);
}

class LogoutDetailsPageState extends DetailsPageState {}
