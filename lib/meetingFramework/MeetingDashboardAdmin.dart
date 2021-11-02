import 'package:abs_fitness/CalenderService/storage.dart';
import 'package:abs_fitness/Model/EventInfo.dart';
import 'package:abs_fitness/meetingFramework/CreateMeeting.dart';
import 'package:abs_fitness/meetingFramework/EditMeeting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../colors.dart';

class MeetingDashboard extends StatefulWidget {
  final String className;

  const MeetingDashboard({Key key, this.className}) : super(key: key);
  @override
  _MeetingDashboardState createState() => _MeetingDashboardState();
}

class _MeetingDashboardState extends State<MeetingDashboard> {
  Storage storage = Storage();

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
          'Event Details',
          style: TextStyle(
            color: CustomColor.dark_blue,
            fontSize: 22,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor.dark_cyan,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateMeeting(),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Container(
          padding: EdgeInsets.only(top: 8.0),
          color: Colors.white,
          child: StreamBuilder(
            stream: storage.retrieveEvents(widget.className),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.documents.length > 0) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> eventInfo =
                          snapshot.data.documents[index].data();

                      EventInfo event = EventInfo.fromMap(eventInfo);

                      DateTime startTime = DateTime.fromMillisecondsSinceEpoch(
                          event.startTimeInEpoch);
                      DateTime endTime = DateTime.fromMillisecondsSinceEpoch(
                          event.endTimeInEpoch);

                      String startTimeString =
                          DateFormat.jm().format(startTime);
                      String endTimeString = DateFormat.jm().format(endTime);
                      String dateString = DateFormat.yMMMMd().format(startTime);

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditMeeting(event: event),
                              ),
                            );
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
                                  color:
                                      CustomColor.neon_green.withOpacity(0.3),
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
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Text(
                                        event.link,
                                        style: TextStyle(
                                          color: CustomColor.dark_blue
                                              .withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 5,
                                          color: CustomColor.neon_green,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'No Events',
                      style: TextStyle(
                        color: Colors.black38,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(CustomColor.sea_blue),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
