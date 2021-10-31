import 'dart:io';

import 'package:abs_fitness/Constants.dart';
import 'package:abs_fitness/Model/ProfileModel.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'event.dart';
import 'state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  Firestore fs;
  FirebaseAuth fa = FirebaseAuth.instance;
  FirebaseStorage fbs = FirebaseStorage.instance;
  var loggedInUser;
  ProfileModel pm;
  File imagePickedFile;
  bool hasImageChanged = false;
  Image imgPicked;
  final picker = ImagePicker();

  ProfileBloc() : super(ProfileState().init());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    } else if (event is LoadProfileEvent) {
      pm = await _getData();
      yield ProfileLoaded(pm);
    } else if (event is EditPageEvent) {
      yield OpenEditState(pm);
    } else if (event is InitChangeProfilePicEvent) {
      await _getImage(event.context);
      yield UpdateImageState(imgPicked);
    } else if (event is SaveEditedDataEvent) {
      _saveData(event.context, event.pm);
      yield SaveEditState(event.pm);
    } else if (event is LogoutEvent) {
      await logout(event.context);
      yield LogoutState();
    }
  }

  Future<ProfileState> init() async {
    return state.clone();
  }

  Future<ProfileModel> _getData() async {
    loggedInUser = await fa.currentUser();
    fs = Firestore.instance;
    var data = await fs
        .collection('Users')
        .document(loggedInUser.uid)
        .collection('Details')
        .document('Details')
        .get();
    String name = await data.data['Name'];
    String email = await data.data['Email'];
    String imgUrl = await data.data['Profile Image'];
    String aboutMe = await data.data['About'];
    int activeClassesNumber = 0;
    int totalClassesNumber = 0;

    Image img;

    if (imgUrl == profileImageAsset) {
      img = Image.asset(profileImageAsset);
    } else {
      img = Image.network(imgUrl);
    }
    ProfileModel pm = new ProfileModel(name, email, aboutMe,
        activeClassesNumber, img, totalClassesNumber, imgUrl);
    return pm;
  }

  void _saveData(BuildContext context, ProfileModel epm) async {
    var reference = fbs.ref().child('Profile Images').child(loggedInUser.email);
    String imgUrl;
    var docDetail = fs
        .collection('Users')
        .document(loggedInUser.uid)
        .collection('Details')
        .document('Details');
    try {
      if (!hasImageChanged) {
        var data = await docDetail.get();
        imgUrl = await data.data["Profile Image"];
      } else {
        StorageUploadTask uploadTask = reference.putFile(imagePickedFile);
        StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
        String url = await storageTaskSnapshot.ref.getDownloadURL();
        imgUrl = url == null ? epm.imgUrl : url;
      }

      await docDetail.setData({
        'Email': epm.emailID,
        'Name': epm.name,
        'Profile Image': imgUrl,
        'About': epm.about
      });
    } catch (e) {
      Alert(
          context: context,
          title: 'Please try Again Something Bad Happened !!');
    }
  }

  Future _getImage(BuildContext context) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);

    if (pickedFile != null) {
      imagePickedFile = File(pickedFile.path);
      var compressedImage = await _compressFile(imagePickedFile);
      imgPicked = compressedImage == null
          ? Image.file(imagePickedFile)
          : Image.file(compressedImage);
      imagePickedFile =
          compressedImage == null ? imagePickedFile : compressedImage;
      hasImageChanged = true;
    } else {
      Alert(
          context: context,
          title: 'Error occurred while trying to pick Image !!');
    }
  }

  // This is coming from flutter_image_compress package.
  // Used here instead of Asset Compression as it performs better
  // Asset compression is used as there that is appropriate
  Future<File> _compressFile(File file) async {
    final filePath = file.absolute.path;
    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 60,
      );
      return result;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
