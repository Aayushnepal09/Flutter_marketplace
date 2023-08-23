import 'package:KinBech/screen/dashboard/setting/user/model/user.dart';
import 'package:KinBech/screen/dashboard/setting/user/utils/user_preferences.dart';
import 'package:KinBech/screen/dashboard/setting/user/widget/appbar_widget.dart';
import 'package:KinBech/screen/dashboard/setting/user/widget/button_widget.dart';
import 'package:KinBech/screen/dashboard/setting/user/widget/profile_widget.dart';
import 'package:KinBech/theme/theme_data.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: COLOR_SECONDARY,
      body: ListView(
        children: [
          const SizedBox(height: 200),
          ProfileWidget(
            imagePath: "assets/images/user.jpg",
            onClicked: () async {},
          ),
          const SizedBox(height: 50),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          //NumbersWidget(),
          // const SizedBox(height: 48),
          // buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 235, 23, 23)),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'demouser',
        onClicked: () {},
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // children: [
          //   Text(
          //     'Other Information',
          //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //   ),
          //   const SizedBox(height: 16),
          //   Text(
          //     user.username,
          //     style: TextStyle(fontSize: 16, height: 1.4),
          //   ),
          // ],
        ),
      );
}
