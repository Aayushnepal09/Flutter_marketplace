import 'package:KinBech/screen/dashboard/dashboard.dart';
import 'package:KinBech/screen/dashboard/dashboardScreens/search/landing.dart';
import 'package:KinBech/screen/dashboard/productDetail/productdetails.dart';
import 'package:KinBech/screen/dashboard/setting/addproduct.dart';
import 'package:KinBech/screen/dashboard/setting/googlemap/googlemap.dart';
import 'package:KinBech/screen/dashboard/setting/setting.dart';
import 'package:KinBech/screen/dashboard/setting/user/page/profile_page.dart';
import 'package:KinBech/screen/login&registration/login.dart';
import 'package:KinBech/screen/login&registration/registration.dart';
import 'package:KinBech/screen/popupPage/page1.dart';
import 'package:KinBech/screen/popupPage/page2.dart';
import 'package:KinBech/theme/theme_data.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KinBech',
      initialRoute: '/',
      theme: getApplicationTheme(),
      routes: {
        '/googlemap': (context) => const GooglemapScreen(),
        // '/': (context) => const LoginWearOSScreen(),
        // '/dashboard': (context) => const BottomNavigation(),
        // ignore: equal_keys_in_map
        '/': (context) => const OnboardingScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/walkthrough': (context) => const WalkthroughScreen(),
        '/login': (context) => const LoginScreen(),
        '/navigation': (context) => const BottomNavigation(),
        '/productdetail': (context) => const ProductDetailScreen(),
        // '/watchlist': (context) => const CartScreen(),
        '/setting': (context) => const SettingsScreen(),
        '/addproduct': (context) => AddProduct(),
        '/landingsearch': (context) => landingscreen(),
        '/profile': (context) => ProfilePage(),
        //'/': (context) => ProfilePage(),
      },
    );
  }
}
