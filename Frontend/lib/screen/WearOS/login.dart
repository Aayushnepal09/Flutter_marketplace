import 'package:KinBech/repository/user_repo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:wear/wear.dart';

class LoginWearOSScreen extends StatefulWidget {
  const LoginWearOSScreen({super.key});

  @override
  State<LoginWearOSScreen> createState() => _LoginWearOSScreenState();
}

//const double _headerHeight = 250;

class _LoginWearOSScreenState extends State<LoginWearOSScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  _loginUser() async {
    final user = await UserRepositoryImpl()
        .loginUser(_usernameController.text, _passwordController.text);
    if (user != null) {
      _goToAnotherPage();
    } else {
      _showMessage();
    }
  }

  _goToAnotherPage() {
    Navigator.pushReplacementNamed(context, "//navigation");
  }

  _showMessage() {
    MotionToast.error(description: const Text('Invalid username or password'))
        .show(context);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(builder: (context, mode, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: _headerHeight,
                    //   child: HeaderWidget(
                    //       _headerHeight,
                    //       true,
                    //       Icons
                    //           .login_rounded),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      width: w,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text("KinBech",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans Bold')),
                            ),
                            const Text("Sign into your account",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 142, 118, 150))),
                            const SizedBox(
                              height: 10,
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
                            const SizedBox(height: 5),
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
                              height: 5,
                            ),
                            const SizedBox(height: 1),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                const Text("Forgot your password?",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color.fromARGB(
                                            255, 186, 171, 191))),
                              ],
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: SizedBox(
                        height: 20,
                        // width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _goToAnotherPage();
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Brand Bold",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(255, 186, 171, 191)),
                          children: [
                            TextSpan(
                              text: " Create? ",
                              style: const TextStyle(
                                  fontSize: 10,
                                  //color: Color.fromARGB(255, 122, 64, 142),
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
            ));
      });
    });
  }
}
