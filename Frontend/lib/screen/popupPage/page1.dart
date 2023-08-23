import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String data = '';

  _getDataFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString('login');
    if (value != null) {
      setState(() {
        data = value;
        Navigator.pushReplacementNamed(context, "/navigation");
      });
    } else {
      setState(() {
        data = 'No data found';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      final prefs = await SharedPreferences.getInstance();
      final isWalthroughShown = prefs.getBool("isWalkthroughShown") ?? false;
      _getDataFromSharedPref();
      if (isWalthroughShown) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, "/login");
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, "/walkthrough");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: (Color.fromARGB(255, 167, 112, 210))));
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            width: screen.width,
            height: screen.height,
            child: Stack(
              children: [
                Center(
                    child: Image.asset(
                  "assets/images/startpage.png",
                  height: 300,
                )),
                Positioned(
                  width: screen.width,
                  bottom: 30,
                  child: Text(
                    "KinBech",
                    style: themeData.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
