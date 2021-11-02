import 'package:abs_fitness/Model/EventInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Firestore fs = Firestore.instance;
final CollectionReference mainCollection =
    Firestore.instance.collection('Classes');

final DocumentReference documentReference = mainCollection.document('Classes');

class Storage {
  Future<void> storeEventData(EventInfo eventInfo) async {
    DocumentReference documentReferencer = documentReference
        .collection('Classes')
        .document('Events')
        .collection(eventInfo.className)
        .document(eventInfo.id);
    Map<String, dynamic> data = eventInfo.toJson();

    for (var s in eventInfo.attendeeEmails) {
      DocumentReference userUIDReference =
          fs.collection('UIDS').document(s.toString().toLowerCase());
      DocumentSnapshot snap = await userUIDReference.get();
      String uid = await snap.data["uid"];
      DocumentReference userDocReference = fs
          .collection('Users')
          .document(uid)
          .collection('Meetings')
          .document(eventInfo.id);
      await userDocReference.setData(data);
    }

    print('DATA:\n$data');

    await documentReferencer.setData(data).whenComplete(() {
      print("Event added to the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> updateEventData(EventInfo eventInfo) async {
    DocumentReference documentReferencer = documentReference
        .collection('Classes')
        .document('Events')
        .collection(eventInfo.className)
        .document(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    for (var s in eventInfo.attendeeEmails) {
      DocumentReference userUIDReference =
          fs.collection('UIDS').document(s.toString().toLowerCase());
      DocumentSnapshot snap = await userUIDReference.get();
      String uid = await snap.data["uid"];
      DocumentReference userDocReference = fs
          .collection('Users')
          .document(uid)
          .collection('Meetings')
          .document(eventInfo.id);
      await userDocReference.updateData(data);
    }
    print('DATA:\n$data');

    await documentReferencer.updateData(data).whenComplete(() {
      print("Event updated in the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> deleteEvent(
      {@required String id,
      @required String planName,
      @required List<dynamic> attendeesList}) async {
    DocumentReference documentReferencer = documentReference
        .collection('Classes')
        .document('Events')
        .collection(planName)
        .document(id);

    for (var s in attendeesList) {
      DocumentReference userUIDReference =
          fs.collection('UIDS').document(s.toString().toLowerCase());
      DocumentSnapshot snap = await userUIDReference.get();
      String uid = await snap.data["uid"];
      DocumentReference userDocReference = fs
          .collection('Users')
          .document(uid)
          .collection('Meetings')
          .document(id);
      await userDocReference.delete();
    }

    await documentReferencer.delete().catchError((e) => print(e));

    print('Event deleted, id: $id');
  }

  Stream<QuerySnapshot> retrieveEvents(String planName) {
    Stream<QuerySnapshot> myClasses = documentReference
        .collection('Classes')
        .document('Events')
        .collection(planName)
        .orderBy('start')
        .snapshots();

    return myClasses;
  }
}
