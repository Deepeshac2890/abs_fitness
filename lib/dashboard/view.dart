import 'package:abs_fitness/Components/BottomBar.dart';
import 'package:abs_fitness/Resources/StringConstants.dart';
import 'package:abs_fitness/dashboard/bloc.dart';
import 'package:abs_fitness/dashboard/event.dart';
import 'package:abs_fitness/dashboard/state.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Resources/W&FConstants.dart';

// TODO: Add the Bottom Bar in profile and Meetings Page.
// TODO: Add Logout option in all the screens in AppBar
// TODO: Disable Dashboard going button if on Dashboard Same for others
// TODO: Prevent Going back if last on stack is login page give pop up to logout

class DashboardPage extends StatefulWidget {
  static String id = "DashboardPage";
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  final DashboardBloc db = DashboardBloc(FirebaseAuth.instance);

  @override
  void initState() {
    controller.addListener(
      () {
        double value = controller.offset / 119;

        setState(
          () {
            topContainer = value;
            closeTopContainer = controller.offset > 50;
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      cubit: db,
      builder: (BuildContext context, state) {
        if (state is DashboardLoaded) {
          return initDashboard(
              context, state.loadedUIElements, userDashboardMessage);
        } else if (state is AdminDashboardLoaded) {
          return initDashboard(
              context, state.loadedUIElements, adminDashboardMessage);
        } else if (state is DashboardLoading) {
          return loadingWidget();
        } else {
          db.add(CheckAdmin(context));
          return loadingWidget();
        }
      },
    );
  }

  Widget initDashboard(
      BuildContext context, List<Widget> uiElements, String message) {
    Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;

    return Scaffold(
      bottomNavigationBar: BottomBar(),
      appBar: appBarWithLogOut(context),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: size.width,
                  alignment: Alignment.topCenter,
                  height: closeTopContainer ? 0 : categoryHeight,
                  child: Container(
                    alignment: Alignment(0.0, -1.0),
                    height: size.height * 0.5,
                    padding: EdgeInsets.all(10),
                    color: Colors.white54,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Image(
                            image: Image.asset("assets/abs.gif").image,
                            height: 100,
                            width: 150,
                          ),
                        ),
                        TypewriterAnimatedTextKit(
                          text: ['Absolute-Fitness'],
                          textStyle: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          message,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: uiElements.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    double scale = 1.0;
                    if (topContainer > 0.5) {
                      scale = index + 0.5 - topContainer;
                      if (scale < 0) {
                        scale = 0;
                      } else if (scale > 1) {
                        scale = 1;
                      }
                    }
                    return Opacity(
                      opacity: scale,
                      child: Transform(
                        transform: Matrix4.identity()..scale(scale, scale),
                        alignment: Alignment.bottomCenter,
                        child: Align(
                            heightFactor: 0.7,
                            alignment: Alignment.topCenter,
                            child: uiElements[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
