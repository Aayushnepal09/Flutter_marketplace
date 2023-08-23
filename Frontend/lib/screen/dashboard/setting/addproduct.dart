import 'dart:async';
import 'dart:io';
import 'package:KinBech/app/permission.dart';
import 'package:KinBech/model/products.dart';
import 'package:KinBech/repository/product_repo.dart';
import 'package:KinBech/theme/theme_data.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _nameController = TextEditingController();
  // final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  // final _cpasswordController = TextEditingController();

  @override
  void initState() {
    _checkUserPermission();
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.requestCameraPermission();
  }

  _saveproduct() async {
    Product products = Product(
      name: _nameController.text,
      price: _lnameController.text,
      //image: _emailController.text,
      description: _passwordController.text,
    );
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: 'Sign in',
          body: "this is sign in test notification"),
    );

    int status = await ProductRepositoryImpl().addProduct(_img, products);
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
        description: const Text('Product add successfully'),
      ).show(context);
    } else {
      MotionToast.error(
        description: const Text('error adding product try again  '),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/navigation'),
          ),
          title: const Text('Add Product'),
          backgroundColor: COLOR_PRIMARY,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _key,
              child: Column(children: [
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
                            Icons.add_to_photos_rounded,
                            size: 100,
                          )
                        : Image.file(_img!),
                  ),
                ),
                const SizedBox(height: 8),
                // TextFormField(
                //   controller: _emailController,
                //   decoration: const InputDecoration(
                //     labelText: 'product namemm',
                //   ),
                //   validator: ((value) {
                //     if (value == null || value.isEmpty) {
                //       return 'pro name';
                //     }
                //     return null;
                //   }),
                // ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'dec';
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
                    labelText: 'price',
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Price';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: null,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'dec',
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'dec';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   controller: _usernameController,
                //   decoration: const InputDecoration(
                //     labelText: 'Enter your Username',
                //   ),
                //   validator: ((value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter Username';
                //     }
                //     return null;
                //   }),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // TextFormField(
                //   obscureText: true,
                //   controller: _passwordController,
                //   decoration: const InputDecoration(
                //     labelText: 'Enter your password',
                //   ),
                //   validator: ((value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter password';
                //     }
                //     return null;
                //   }),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // TextFormField(
                //   obscureText: true,
                //   controller: _cpasswordController,
                //   decoration: const InputDecoration(
                //     labelText: 'Confirm Password',
                //   ),
                //   // validator: ((value) {
                //   //   if (value == null || value.isEmpty) {
                //   //     return 'Please enter your password';
                //   //   } else if (value != _passwordController) {
                //   //     return 'password and confirm password does not match';
                //   //   }
                //   //   return null;
                //   // }),
                // ),
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
                          _saveproduct();
                        }
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Brand Bold",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.05),
                // RichText(
                //   text: TextSpan(
                //     text: "Already have an account?",
                //     style: const TextStyle(
                //         fontSize: 15,
                //         color: Color.fromARGB(255, 186, 171, 191)),
                //     children: [
                //       TextSpan(
                //         text: "Login ",
                //         style: const TextStyle(
                //             fontSize: 15,
                //             color: Color.fromARGB(255, 64, 142, 138),
                //             fontWeight: FontWeight.bold),
                //         recognizer: TapGestureRecognizer()
                //           ..onTap = () =>
                //               Navigator.pushReplacementNamed(context, "/login"),
                //       ),
                //     ],
                //   ),
                // ),
              ]),
            ),
          ),
        ));
  }
}
