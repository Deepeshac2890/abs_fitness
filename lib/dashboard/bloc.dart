import 'package:abs_fitness/Resources/AdminUIDS.dart';
import 'package:abs_fitness/admin_details_page/view.dart';
import 'package:abs_fitness/details_page/view.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Resources/planConstant.dart';
import 'event.dart';
import 'state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState().init());
  FirebaseAuth fa = FirebaseAuth.instance;

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    } else if (event is CheckAdmin) {
      List<Widget> loadedUI = [];
      FirebaseUser currentUser = await fa.currentUser();
      if (!isAdmin(currentUser.uid)) {
        loadedUI = getData(event.context);
        yield DashboardLoaded(loadedUI);
      } else {
        loadedUI = getAdminData(event.context);
        yield AdminDashboardLoaded(loadedUI);
      }
    }
  }

  Future<DashboardState> init() async {
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
                    return DetailsPage(
                      planName: post["title"],
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

  List<Widget> getAdminData(BuildContext context) {
    List<dynamic> responseList = planContants;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AdminDetailsPage(
                    planName: post["title"],
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
    });
    return listItems;
  }
}
