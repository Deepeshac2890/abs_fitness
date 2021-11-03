import 'package:abs_fitness/Components/BottomBar.dart';
import 'package:abs_fitness/details_page/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Resources/W&FConstants.dart';
import 'bloc.dart';
import 'state.dart';

class DetailsPage extends StatefulWidget {
  final String planName;
  static final id = "DetailsPage";

  const DetailsPage({Key key, this.planName}) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsPageBloc db = DetailsPageBloc();

  @override
  void dispose() {
    db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: db,
      builder: (context, state) {
        if (state is LoadedPageState) {
          return detailsUI(context, state.detailsWidget);
        } else {
          db.add(LoadPageEvent(widget.planName, context));
          return detailsUI(context, loadingWidget());
        }
      },
    );
  }

  Widget detailsUI(BuildContext context, Widget body) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      body: body,
      appBar: appBarWithLogOut(context),
    );
  }
}

// ignore: must_be_immutable
// class DetailsPage extends StatelessWidget {
//   static final id = "DetailsPage";
//   final DetailsPageBloc db = DetailsPageBloc();
//   final String planName;
//
//   DetailsPage({this.planName});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder(
//       cubit: db,
//       builder: (context, state) {
//         if (state is LoadedPageState) {
//           return detailsUI(context, state.detailsWidget);
//         } else {
//           db.add(LoadPageEvent(planName, context));
//           return detailsUI(context, loadingWidget());
//         }
//       },
//     );
//   }
//
//   Widget detailsUI(BuildContext context, Widget body) {
//     return Scaffold(
//       bottomNavigationBar: BottomBar(),
//       body: body,
//       appBar: appBarWithLogOut(context),
//     );
//   }
// }
