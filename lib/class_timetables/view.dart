import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'event.dart';

class ClassTimetablesPage extends StatelessWidget {
  static final String id = "ClassTimeTable";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ClassTimetablesBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ClassTimetablesBloc>(context);

    return Container();
  }
}
