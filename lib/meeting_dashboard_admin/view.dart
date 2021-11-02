import 'package:abs_fitness/meeting_dashboard_admin/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Constants.dart';
import 'bloc.dart';
import 'state.dart';

class MeetingDashboardAdminPage extends StatefulWidget {
  static String id = "MeetingDashboardAdmin";
  @override
  _MeetingDashboardAdminPageState createState() =>
      _MeetingDashboardAdminPageState();
}

class _MeetingDashboardAdminPageState extends State<MeetingDashboardAdminPage> {
  final MeetingDashboardAdminBloc mdb = MeetingDashboardAdminBloc();
  ScrollController controller = ScrollController();
  double topContainer = 0;

  @override
  void dispose() {
    mdb.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MeetingDashboardAdminBloc, MeetingDashboardAdminState>(
        cubit: mdb,
        builder: (context, state) {
          if (state is LoadingUI) {
            return loadingWidget();
          } else if (state is UILoaded) {
            return initDashboard(context, state.uiElements);
          } else {
            mdb.add(LoadMeetingDashboardEvent(context));
            return loadingWidget();
          }
        },
        listener: (context, state) {});
  }

  Widget initDashboard(BuildContext context, List<Widget> uiElements) {
    return Scaffold(
      appBar: appBarWithLogOut(context),
      body: Container(
        child: SafeArea(
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
                    child: uiElements[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
