import 'package:abs_fitness/Components/BottomBar.dart';
import 'package:abs_fitness/details_page/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Resources/Constants.dart';
import 'bloc.dart';
import 'state.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  static final id = "DetailsPage";
  final DetailsPageBloc db = DetailsPageBloc();
  final String planName;

  DetailsPage({this.planName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: db,
      builder: (context, state) {
        if (state is LoadedPageState) {
          return detailsUI(context, state.detailsWidget);
        } else {
          db.add(LoadPageEvent(planName, context));
          return detailsUI(context, loadingWidget());
        }
      },
    );
  }

  Widget detailsUI(BuildContext context, Widget body) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      body: body,
      appBar: appBar(context),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            db.add(LogoutDetailsPageEvent(context));
          },
        ),
      ],
    );
  }
}
