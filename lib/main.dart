import 'dart:io';

import 'package:abs_fitness/CalenderService/calender_client.dart';
import 'package:abs_fitness/Resources/secrets.dart';
import 'package:abs_fitness/Screens/WelcomeScreen.dart';
import 'package:abs_fitness/admin_details_page/view.dart';
import 'package:abs_fitness/dashboard/view.dart';
import 'package:abs_fitness/details_page/view.dart';
import 'package:abs_fitness/login/view.dart';
import 'package:abs_fitness/meetingFramework/MeetingClassDashboardAdmin.dart';
import 'package:abs_fitness/meetingFramework/MeetingClassDashboardUser.dart';
import 'package:abs_fitness/meeting_dashboard_admin/view.dart';
import 'package:abs_fitness/profile/view.dart';
import 'package:abs_fitness/registration/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO: Deal with the app always asking meet permission from User
// TODO: Close all the streams
// TODO: See Local BLOC Implementation and note it in Notes
// TODO: In notes update the placement of Expanded widgets where to be done

Future<void> main() async {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
  }
  WidgetsFlutterBinding.ensureInitialized();

  var _clientID = new ClientId(Secret.getID(), "");
  const _scopes = const [cal.CalendarApi.CalendarScope];
  await clientViaUserConsent(_clientID, _scopes, prompt)
      .then((AuthClient client) async {
    CalendarClient.calendar = cal.CalendarApi(client);
  });
  runApp(MyApp());
}

void prompt(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        DashboardPage.id: (context) => DashboardPage(),
        LoginPage.id: (context) => LoginPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        DetailsPage.id: (context) => DetailsPage(
              planName: null,
            ),
        AdminDetailsPage.id: (context) => AdminDetailsPage(
              planName: null,
            ),
        ProfilePage.id: (context) => ProfilePage(),
        MeetingClassDashboardUser.id: (context) => MeetingClassDashboardUser(),
        MeetingClassDashboardAdmin.id: (context) =>
            MeetingClassDashboardAdmin(),
        MeetingDashboardAdminPage.id: (context) => MeetingDashboardAdminPage(),
      },
    );
  }
}
