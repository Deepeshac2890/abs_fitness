import 'package:flutter/material.dart';

class ProfileModel {
  String name;
  String emailID;
  String about;
  int activeClassesNumber;
  Image img;
  int totalClassesNumber;
  String imgUrl;

  ProfileModel(this.name, this.emailID, this.about, this.activeClassesNumber,
      this.img, this.totalClassesNumber, this.imgUrl);
}
