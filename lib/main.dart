import 'package:abs_fitness/Screens/WelcomeScreen.dart';
import 'package:abs_fitness/dashboard/bloc.dart';
import 'package:abs_fitness/dashboard/view.dart';
import 'package:abs_fitness/login/bloc.dart';
import 'package:abs_fitness/login/view.dart';
import 'package:abs_fitness/registration/bloc.dart';
import 'package:abs_fitness/registration/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginBloc()),
        BlocProvider(create: (BuildContext context) => RegistrationBloc()),
        BlocProvider(create: (BuildContext context) => DashboardBloc()),
      ],
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          DashboardPage.id: (context) => DashboardPage(),
          LoginPage.id: (context) => LoginPage(),
          RegistrationPage.id: (context) => RegistrationPage(),
        },
      ),
    );
  }
}
