import 'package:KinBech/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    BottomNavigation();
    ShakeDetector.autoStart(onPhoneShake: () {
      final Future<SharedPreferences> sharedPref =
          SharedPreferences.getInstance();
      sharedPref.then((value) {
        value.remove('token');
      });
      Navigator.pushNamed(context, '/login');
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Settings",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                SettingsTile(
                  color: Colors.grey,
                  icon: Icons.person,
                  title: "About Me",
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/profile");
                  },
                ),
                const SizedBox(height: 40),
                SettingsTile(
                  color: Colors.grey,
                  icon: Icons.add_rounded,
                  title: "Add Product",
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/addproduct");
                  },
                ),
                const SizedBox(height: 40),
                SettingsTile(
                  color: Colors.blue,
                  icon: Icons.logo_dev_rounded,
                  title: "About Us",
                  onTap: () {},
                ),
                const SizedBox(height: 40),
                SettingsTile(
                  color: Colors.green,
                  icon: Icons.maps_home_work_rounded,
                  title: "Find us",
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/googlemap");
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                SettingsTile(
                  color: const Color.fromARGB(255, 227, 17, 17),
                  icon: Icons.logout,
                  title: "logout",
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            child: SizedBox(
                              height: 120,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //scrossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                        "Are You sure you want to Logout?",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () {
                                          final Future<SharedPreferences>
                                              sharedPref =
                                              SharedPreferences.getInstance();
                                          sharedPref.then((value) {
                                            value.remove('token');
                                          });
                                          Navigator.pushNamed(
                                              context, '/login');
                                        },
                                        child: const Text(
                                          "Logout",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  //onTap: () => Navigator.pushReplacementNamed(context, "/login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Arrow button theme
class SettingsTile extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const SettingsTile({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: onTap,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.arrow_forward_ios),
          ),
        )
      ],
    );
  }
}
