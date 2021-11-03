import 'package:abs_fitness/Components/BottomBar.dart';
import 'package:abs_fitness/Resources/Constants.dart';
import 'package:abs_fitness/Model/ProfileModel.dart';
import 'package:abs_fitness/profile/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'event.dart';

class ProfilePage extends StatefulWidget {
  static String id = "ProfilePage";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileModel editedPM;
  final ProfileBloc pb = ProfileBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: pb,
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return profileLoaded(context, state.pm);
        } else if (state is OpenEditState) {
          editedPM = state.pm;
          return editProfile(context);
        } else if (state is SaveEditState) {
          return profileLoaded(context, state.pm);
        } else if (state is UpdateImageState) {
          editedPM.img = state.imgUpdate;
          return editProfile(context);
        } else {
          pb.add(LoadProfileEvent());
          return loadingWidget();
        }
      },
    );
  }

  Widget profileLoaded(BuildContext context, ProfileModel pm) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          LogoutButton(
            onPressed: () {
              pb.add(LogoutEvent(context));
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileImageWidget(
            image: pm.img,
            isEdit: false,
            onButtonClick: () {
              pb.add(EditPageEvent());
            },
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Text(
                pm.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                pm.emailID,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Stats(
            pm: pm,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  pm.about,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget editProfile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          LogoutButton(
            onPressed: () {
              pb.add(LogoutEvent(context));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileImageWidget(
              image: editedPM.img,
              isEdit: true,
              onButtonClick: () {
                pb.add(InitChangeProfilePicEvent(context, editedPM));
              },
            ),
            SizedBox(
              height: 20,
            ),
            EditTextFormField(
              editedPM: editedPM,
              labelText: "Name",
              initialValue: editedPM.name,
              onChanged: (name) {
                editedPM.name = name;
              },
            ),
            SizedBox(
              height: 20,
            ),
            EditTextFormField(
              editedPM: editedPM,
              labelText: "Email",
              initialValue: editedPM.emailID,
              onChanged: (email) {
                editedPM.emailID = email;
              },
            ),
            SizedBox(
              height: 20,
            ),
            EditTextFormField(
              initialValue: editedPM.about,
              editedPM: editedPM,
              labelText: "About",
              onChanged: (about) {
                editedPM.about = about;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text("Save"),
              onPressed: () {
                pb.add(SaveEditedDataEvent(editedPM, context));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final Function onPressed;

  LogoutButton({Key key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.logout,
          color: Colors.black,
        ),
        onPressed: onPressed);
  }
}

class EditTextFormField extends StatelessWidget {
  const EditTextFormField({
    Key key,
    @required this.editedPM,
    this.labelText,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  final ProfileModel editedPM;
  final labelText;
  final Function onChanged;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        helperText: labelText,
        helperStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class ProfileImageWidget extends StatelessWidget {
  final Image image;
  final Function onButtonClick;
  final bool isEdit;

  const ProfileImageWidget(
      {Key key, this.image, this.onButtonClick, this.isEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: image.image,
                fit: BoxFit.cover,
                height: 128,
                width: 128,
                child: InkWell(
                  onTap: () {},
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: ClipOval(
                child: Container(
                  height: 60,
                  width: 60,
                  color: Colors.white,
                  child: Center(
                    child: ClipOval(
                      child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.blue,
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                            iconSize: 20,
                            color: Colors.white,
                            icon: Icon(
                                isEdit ? Icons.camera_enhance : Icons.edit),
                            onPressed: onButtonClick),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class Stats extends StatelessWidget {
  final ProfileModel pm;

  const Stats({Key key, this.pm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatButton(
            count: pm.activeClassesNumber.toString(), title: "Active Classes"),
        StatsDivider(),
        StatButton(
            count: pm.totalClassesNumber.toString(), title: "Total Classes"),
      ],
    );
  }
}

class StatsDivider extends StatelessWidget {
  const StatsDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: VerticalDivider(
        color: Colors.black,
      ),
    );
  }
}

class StatButton extends StatelessWidget {
  final String count;
  final String title;

  const StatButton({Key key, this.count, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(4),
      onPressed: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            count,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
