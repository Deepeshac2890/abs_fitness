import 'package:abs_fitness/CalenderService/storage.dart';
import 'package:abs_fitness/Model/EventInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colors.dart';

class MeetingClassDashboardUser extends StatefulWidget {
  static String id = "MeetingDashboardUser";
  @override
  _MeetingClassDashboardUserState createState() =>
      _MeetingClassDashboardUserState();
}

class _MeetingClassDashboardUserState extends State<MeetingClassDashboardUser> {
  Storage storage = Storage();
  EventInfo event;
  List<Widget> ls = [];
  Firestore fs;
  QuerySnapshot snap;
  int snapLength = 0;
  FirebaseAuth fa = FirebaseAuth.instance;

  void getData() async {
    var currentUser = await fa.currentUser();
    String uid = currentUser.uid;
    fs = Firestore.instance;
    snap = await fs
        .collection('Users')
        .document(uid)
        .collection('Meetings')
        .orderBy('start')
        .reference()
        .getDocuments();
    snapLength = snap.documents.length;
    print(snapLength);
    for (DocumentSnapshot docSnap in snap.documents) {
      EventInfo event = await EventInfo.fromDocumentSnapshot(docSnap);
      DateTime startTime =
          DateTime.fromMillisecondsSinceEpoch(event.startTimeInEpoch);
      DateTime endTime =
          DateTime.fromMillisecondsSinceEpoch(event.endTimeInEpoch);

      String startTimeString = DateFormat.jm().format(startTime);
      String endTimeString = DateFormat.jm().format(endTime);
      String dateString = DateFormat.yMMMMd().format(startTime);

      ls.add(
        Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: InkWell(
            onTap: () {
              launch(event.link);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: 16.0,
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.neon_green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name,
                        style: TextStyle(
                          color: CustomColor.dark_blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        event.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          event.link,
                          style: TextStyle(
                            color: CustomColor.dark_blue.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 5,
                            color: CustomColor.neon_green,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dateString,
                                style: TextStyle(
                                  color: CustomColor.dark_cyan,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                '$startTimeString - $endTimeString',
                                style: TextStyle(
                                  color: CustomColor.dark_cyan,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey, //change your color here
        ),
        title: Text(
          'Classes Details',
          style: TextStyle(
            color: CustomColor.dark_blue,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Container(
          padding: EdgeInsets.only(top: 8.0),
          color: Colors.white,
          child: snapLength > 0
              ? ListView(
                  children: ls,
                  physics: BouncingScrollPhysics(),
                )
              : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(CustomColor.sea_blue),
                  ),
                ),
        ),
      ),
    );
  }

  void initEventInfo(DocumentSnapshot snap) async {
    event = await EventInfo.fromDocumentSnapshot(snap);
  }
}
