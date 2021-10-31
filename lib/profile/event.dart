import 'package:abs_fitness/Model/ProfileModel.dart';
import 'package:flutter/cupertino.dart';

abstract class ProfileEvent {}

class InitEvent extends ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class InitChangeProfilePicEvent extends ProfileEvent {
  final BuildContext context;
  final ProfileModel pm;

  InitChangeProfilePicEvent(this.context, this.pm);
}

class CompleteUpdateProfilePic extends ProfileEvent {}

class EditPageEvent extends ProfileEvent {}

class SaveEditedDataEvent extends ProfileEvent {
  final ProfileModel pm;
  final BuildContext context;

  SaveEditedDataEvent(this.pm, this.context);
}

class LogoutEvent extends ProfileEvent {
  final BuildContext context;

  LogoutEvent(this.context);
}
