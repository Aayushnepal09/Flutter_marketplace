import 'package:KinBech/model/user.dart';
import 'package:KinBech/repository/user_repo.dart';
import 'package:KinBech/theme/header_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final double _headerHeight = 250;
  final _key = GlobalKey<FormState>();

  _setDataTosharedPref(String text) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('login', text);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _loginUser() async {
    final user = await UserRepositoryImpl()
        .loginUser(_usernameController.text, _passwordController.text);

    if (user) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: 'Sign in',
            body: "this is sign in test notification"),
      );
      //_setDataTosharedPref(_usernameController.text);
      _goToAnotherPage();
    } else {
      _showMessage();
    }
  }

  _goToAnotherPage() {
    Navigator.pushReplacementNamed(context, "/navigation");
  }

  _showMessage() {
    MotionToast.error(description: const Text('Invalid username or password'))
        .show(context);
  }

  _showUsers() async {
    List<User> lstUsers = await UserRepositoryImpl().getUsers();
    for (User s in lstUsers) {
      debugPrint(s.username);
      debugPrint(s.password);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(
                height: _headerHeight,
                child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text("KinBech",
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans Bold')),
                      ),
                      const Text("Sign into your account",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 11, 1, 15))),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Enter your username',
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                            labelText: 'Enter your password'),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          const Text("Forgot your password?",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 0, 10, 9))),
                        ],
                      ),
                    ]),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _loginUser();
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Brand Bold",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.08),
              RichText(
                text: TextSpan(
                    text: "Don't have an account?",
                    style: const TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 8, 0, 10)),
                    children: [
                      TextSpan(
                        text: "Create ",
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 17, 192, 61),
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacementNamed(
                              context, "/registration"),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
