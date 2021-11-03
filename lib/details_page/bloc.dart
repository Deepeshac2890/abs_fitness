import 'package:abs_fitness/Components/ReusablePaddingWidget.dart';
import 'package:abs_fitness/Resources/StringConstants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Resources/W&FConstants.dart';
import 'event.dart';
import 'state.dart';

class DetailsPageBloc extends Bloc<DetailsPageEvent, DetailsPageState> {
  DetailsPageBloc() : super(DetailsPageState().init());
  FirebaseAuth fa = FirebaseAuth.instance;
  Firestore fs = Firestore.instance;

  @override
  Stream<DetailsPageState> mapEventToState(DetailsPageEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    } else if (event is LoadPageEvent) {
      yield LoadedPageState(loadDetails(event.planName, event.context));
    }
  }

  Future<DetailsPageState> init() async {
    return state.clone();
  }

  Widget loadDetails(String planName, BuildContext context) {
    String details = "";
    String imgName = "assets/default.png";
    // Default Phone Number
    String phoneNumber = "7887020286";
    planConstants.forEach(
      (element) {
        if (element["title"] == planName) {
          details = element["Details"];
          imgName = "assets/" + element["image"];
          phoneNumber = element["Number"];
        }
      },
    );
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Image(
              image: Image.asset(imgName).image,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: kMessageContainerDecoration,
              child: Text(details),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Paddy(
                  op: () {
                    launch('tel:+$phoneNumber');
                  },
                  textVal: "Call Now",
                  bColor: Colors.redAccent,
                ).getPadding(),
                Paddy(
                  op: () {
                    sendEnquiry(planName, phoneNumber);
                  },
                  textVal: "Contact Me",
                  bColor: Colors.redAccent,
                ).getPadding(),
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }

  /// Function used to send enquiry request to Admins.
  Future<void> sendEnquiry(String planName, String phnNumber) async {
    FirebaseUser user = await fa.currentUser();
    String uid = user.uid;
    DocumentSnapshot ds = await fs
        .collection("Users")
        .document(uid)
        .collection("Details")
        .document("Details")
        .get();
    String emailID = await ds.data["Email"];
    String name = await ds.data["Name"];
    String phoneNumber = await ds.data["Phone Number"];
    String profileImage = await ds.data["Profile Image"];

    String message = "Hey I wanted to enquire about " +
        planName +
        ".\n" +
        "My Details are : \n" +
        "Email ID : " +
        emailID +
        "\n" +
        "Name : " +
        name +
        "\n" +
        "Phone Number : " +
        phoneNumber;

    await fs.collection("Inquiry").document("List").collection(planName).add(
      {
        "Name": name,
        "Phone Number": phoneNumber,
        "Email": emailID,
        "Image": profileImage,
      },
    );

    await launch("sms:$phnNumber?body=$message");
  }
}
