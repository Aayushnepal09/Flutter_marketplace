import 'dart:async';
import 'dart:io';
import 'package:KinBech/app/permission.dart';
import 'package:KinBech/model/user.dart';
import 'package:KinBech/repository/user_repo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpasswordController = TextEditingController();

  @override
  void initState() {
    _checkUserPermission();
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.requestCameraPermission();
  }

  _saveUser() async {
    User user = User(
      fname: _fnameController.text,
      lname: _lnameController.text,
      email: _emailController.text,
      username: _usernameController.text,
      password: _passwordController.text,
    );

    int status = await UserRepositoryImpl().addUser(_img, user);
    _showMessage(status);
  }

  File? _img;

  Future _browseImage(ImageSource imageSource) async {
    try {
      // Source is either Gallary or Camera
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _showMessage(int status) {
    if (status > 0) {
      MotionToast.success(
        description: const Text('User registered successfully'),
      ).show(context);
      // Timer(const Duration(seconds: 3), () {
      //   Navigator.pushReplacementNamed(context, "/login");
      // });
    } else {
      MotionToast.error(
        description: const Text(
            'Make sure the user name is longer than 5 words or try using diffrent username '),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                // Stack(
                //   children: [
                //     Container(
                //       padding: const EdgeInsets.all(10),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(100),
                //         border: Border.all(width: 5, color: Colors.white),
                //         color: Colors.white,
                //         boxShadow: const [
                //           BoxShadow(
                //             color: Colors.black12,
                //             blurRadius: 20,
                //             offset: Offset(5, 5),
                //           ),
                //         ],
                //       ),
                //       child: Icon(
                //         Icons.person,
                //         color: Colors.grey.shade300,
                //         size: 80.0,
                //       ),
                //     ),
                //     Container(
                //       padding: const EdgeInsets.fromLTRB(80, 80, 0, 0),
                //       child: const Icon(
                //         Icons.add_circle,
                //         color: Color.fromARGB(255, 18, 9, 9),
                //         size: 25.0,
                //       ),
                //     ),
                //   ],
                // ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: const Color.fromARGB(255, 6, 0, 0),
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                _browseImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.camera),
                              label: const Text('Camera'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _browseImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.image),
                              label: const Text('Gallery'),
                            )
                          ],
                        ),
                      ),
                    );
                  },

                  //Add Image
                  child: SizedBox(
                    height: 200,
                    width: double.infinity - 500,
                    child: _img == null
                        ? const Icon(
                            Icons.add_a_photo_rounded,
                            size: 100,
                          )
                        : Image.file(_img!),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _fnameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your First name',
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Firstname';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _lnameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Last name',
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Last name';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Email',
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Username',
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your password',
                  ),
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
                TextFormField(
                  obscureText: true,
                  controller: _cpasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  // validator: ((value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your password';
                  //   } else if (value != _passwordController) {
                  //     return 'password and confirm password does not match';
                  //   }
                  //   return null;
                  // }),
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
                          _saveUser();
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Brand Bold",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.05),
                RichText(
                  text: TextSpan(
                      text: "Already have an account?",
                      style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 186, 171, 191)),
                      children: [
                        TextSpan(
                          text: "Login ",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 64, 142, 138),
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacementNamed(
                                context, "/login"),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
