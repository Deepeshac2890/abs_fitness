import 'package:abs_fitness/Model/ProfileModel.dart';
import 'package:flutter/material.dart';

class ProfileState {
  ProfileState init() {
    return ProfileState();
  }

  ProfileState clone() {
    return ProfileState();
  }
}

class ProfileLoaded extends ProfileState {
  final ProfileModel pm;

  ProfileLoaded(this.pm);
}

class LoadingState extends ProfileState {}

class OpenEditState extends ProfileState {
  final ProfileModel pm;

  OpenEditState(this.pm);
}

class SaveEditState extends ProfileState {
  final ProfileModel pm;

  SaveEditState(this.pm);
}

class UpdateImageState extends ProfileState {
  final Image imgUpdate;

  UpdateImageState(this.imgUpdate);
}

class LogoutState extends ProfileState {}
