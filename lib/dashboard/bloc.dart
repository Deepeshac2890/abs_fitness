import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constant.dart';
import 'event.dart';
import 'state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState().init());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is InitEvent) {
      print("yaha to aa jaa !!!");
      yield await init();
    } else if (event is CreateListWidgets) {
      List<Widget> plansLoaded = getData();
      yield DashboardLoaded(plansLoaded);
    }
  }

  Future<DashboardState> init() async {
    return state.clone();
  }

  List<Widget> getData() {
    print("Data Get Started");
    List<dynamic> responseList = dashboardUI;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(
        Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
      );
    });
    return listItems;
  }
}
