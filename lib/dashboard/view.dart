import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'event.dart';

class DashboardPage extends StatelessWidget {
  static final id = "DashboardPage";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DashboardBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<DashboardBloc>(context);

    return Container();
  }
}
