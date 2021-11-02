import 'package:abs_fitness/meetingFramework/MeetingClassDashboardAdmin.dart';
import 'package:abs_fitness/planConstant.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'event.dart';
import 'state.dart';

class MeetingDashboardAdminBloc
    extends Bloc<MeetingDashboardAdminEvent, MeetingDashboardAdminState> {
  MeetingDashboardAdminBloc() : super(MeetingDashboardAdminState().init());

  @override
  Stream<MeetingDashboardAdminState> mapEventToState(
      MeetingDashboardAdminEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    } else if (event is LoadMeetingDashboardEvent) {
      List<Widget> uiElements = getData(event.context);
      yield UILoaded(uiElements);
    }
  }

  Future<MeetingDashboardAdminState> init() async {
    return state.clone();
  }

  List<Widget> getData(BuildContext context) {
    List<dynamic> responseList = planContants;
    List<Widget> listItems = [];
    responseList.forEach(
      (post) {
        listItems.add(
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MeetingClassDashboardAdmin(
                      className: post["title"],
                    );
                  },
                ),
              );
            },
            child: Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(100), blurRadius: 10.0),
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: Image.asset("assets/${post["image"]}").image,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      post["title"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    return listItems;
  }
}
