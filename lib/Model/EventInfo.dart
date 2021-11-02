import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventInfo {
  final String id;
  final String name;
  final String description;
  final String className;
  final String link;
  final List<dynamic> attendeeEmails;
  final bool shouldNotifyAttendees;
  final bool hasConferencingSupport;
  final int startTimeInEpoch;
  final int endTimeInEpoch;
  final String recurrenceEndDate;

  EventInfo({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.className,
    @required this.link,
    @required this.attendeeEmails,
    @required this.shouldNotifyAttendees,
    @required this.hasConferencingSupport,
    @required this.startTimeInEpoch,
    @required this.endTimeInEpoch,
    @required this.recurrenceEndDate,
  });

  EventInfo.fromMap(Map snapshot)
      : id = snapshot['id'] ?? '',
        name = snapshot['name'] ?? '',
        description = snapshot['desc'],
        className = snapshot['class'],
        link = snapshot['link'],
        attendeeEmails = snapshot['emails'] ?? '',
        shouldNotifyAttendees = snapshot['should_notify'],
        hasConferencingSupport = snapshot['has_conferencing'],
        startTimeInEpoch = snapshot['start'],
        endTimeInEpoch = snapshot['end'],
        recurrenceEndDate = snapshot['recurrence'];

  static Future<EventInfo> fromDocumentSnapshot(
      DocumentSnapshot snapshot) async {
    EventInfo event = EventInfo(
        id: await snapshot.data['id'] ?? '',
        name: await snapshot.data['name'] ?? '',
        description: await snapshot.data['desc'],
        className: await snapshot.data['class'],
        link: await snapshot.data['link'],
        attendeeEmails: await snapshot.data['emails'] ?? '',
        shouldNotifyAttendees: await snapshot.data['should_notify'],
        hasConferencingSupport: await snapshot.data['has_conferencing'],
        startTimeInEpoch: await snapshot.data['start'],
        endTimeInEpoch: await snapshot.data['end'],
        recurrenceEndDate: await snapshot.data['recurrence']);

    return event;
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'desc': description,
      'class': className,
      'link': link,
      'emails': attendeeEmails,
      'should_notify': shouldNotifyAttendees,
      'has_conferencing': hasConferencingSupport,
      'start': startTimeInEpoch,
      'end': endTimeInEpoch,
      'recurrence': recurrenceEndDate,
    };
  }
}
