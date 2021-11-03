import 'package:abs_fitness/Resources/AdminUIDS.dart';
import 'package:abs_fitness/dashboard/view.dart';
import 'package:abs_fitness/meetingFramework/MeetingClassDashboardUser.dart';
import 'package:abs_fitness/meeting_dashboard_admin/view.dart';
import 'package:abs_fitness/profile/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final context;
  FirebaseAuth fa = FirebaseAuth.instance;
  BottomBar({this.context});
  String uid;

  void getCurrentUID() async {
    var currUser = await fa.currentUser();
    uid = currUser.uid;
  }

  @override
  Widget build(BuildContext ctx) {
    getCurrentUID();
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomBarIcons(
              icon: Icons.dashboard,
              color2: Colors.redAccent,
              color1: Colors.blue,
              iconText: 'Dashboard',
              tapFunc: () {
                Navigator.pushNamed(ctx, DashboardPage.id);
              },
            ),
            BottomBarIcons(
              icon: Icons.list,
              color1: Colors.blue,
              color2: Colors.redAccent,
              iconText: 'Meetings',
              tapFunc: () {
                Navigator.push(
                  ctx,
                  MaterialPageRoute(
                    builder: (context) {
                      if (isAdmin(uid)) {
                        return MeetingDashboardAdminPage();
                      } else
                        return MeetingClassDashboardUser();
                    },
                  ),
                );
              },
            ),
            BottomBarIcons(
              icon: Icons.person,
              color1: Colors.blue,
              color2: Colors.redAccent,
              iconText: 'My Profile',
              tapFunc: () {
                Navigator.push(
                  ctx,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBarIcons extends StatelessWidget {
  final icon;
  final tapFunc;
  final color1;
  final color2;
  final iconText;
  BottomBarIcons(
      {this.icon, this.tapFunc, this.color1, this.color2, this.iconText});
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color1, // button color
        child: InkWell(
          onLongPress: () {
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(
              SnackBar(
                elevation: 0,
                backgroundColor: Colors.white,
                content: Text(
                  iconText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          },
          splashColor: color2, // inkwell color
          child: SizedBox(width: 56, height: 56, child: Icon(icon)),
          onTap: tapFunc,
        ),
      ),
    );
  }
}
