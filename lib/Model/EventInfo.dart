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
