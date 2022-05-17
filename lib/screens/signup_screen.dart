import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:identity_project/resources/auth_methods.dart';
import 'package:identity_project/utils/colors.dart';
import 'package:identity_project/utils/utils.dart';
import 'package:identity_project/widgets/image_logo.dart';
import 'package:identity_project/widgets/text_input_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Creamos controllers para pasar a los inputs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passController.text,
        username: _usernameController.text,
        file: _image!);

    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: Container(), flex: 1),
                // const SizedBox(
                //   height: 17,
                // ),
                // **************************************************************
                //                    LOGO SVG
                // **************************************************************
                const ImageLogo(),
                // **************************************************************
                //            SPACE BETWEEN LOGO AND PROFILE IMAGE
                // **************************************************************
                const SizedBox(
                  height: 17,
                ),
                // **************************************************************
                //                    PROFILE IMAGE
                // **************************************************************
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 45,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1494253109108-2e30c049369b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                          ),
                    Positioned(
                      bottom: -8,
                      right: -7,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                // **************************************************************
                //            SPACE BETWEEN PROFILE IMAGE AND INPUT
                // **************************************************************
                const SizedBox(
                  height: 20,
                ),
                // **************************************************************
                //                    EMAIL INPUT
                // **************************************************************
                TextInputField(
                  controller: _emailController,
                  hint: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                ),
                // **************************************************************
                //           SPACE BETWEEN EMAIL AND USERNAME
                // **************************************************************
                const SizedBox(height: 27),
                // **************************************************************
                //                    USERNAME INPUT
                // **************************************************************
                TextInputField(
                  controller: _usernameController,
                  hint: 'Enter your username',
                  textInputType: TextInputType.text,
                ),
                // **************************************************************
                //           SPACE BETWEEN USERNAME AND PASSWORD
                // **************************************************************
                const SizedBox(height: 27),
                // **************************************************************
                //                    PASSWORD INPUT
                // **************************************************************
                TextInputField(
                  controller: _passController,
                  hint: 'Enter your password',
                  isPass: true,
                  textInputType: TextInputType.text,
                ),
                // **************************************************************
                //           SPACE BETWEEN PASSWORD AND BUTTONS
                // **************************************************************
                const SizedBox(height: 27),
                // **************************************************************
                //           SPACE BETWEEN INPUTS AND BUTTONS
                // **************************************************************
                const SizedBox(height: 27),
                // **************************************************************
                //                    Signup BUTTON
                // **************************************************************
                InkWell(
                  onTap: signUpUser,
                  child: _isLoading
                      ? Stack(
                          children: [
                            Center(
                              child: Lottie.asset(
                                'assets/json/loading.json',
                                width: 175,
                                height: 175,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Creating user...',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            color: pinkColor,
                          ),
                        ),
                ),
                // **************************************************************
                //      SPACE BETWEEN SIGNUP BUTTON AND SIGN IN "BUTTON"
                // **************************************************************
                // const SizedBox(height: 20),
                Flexible(child: Container(), flex: 2),

                // **************************************************************
                //                    SIGNUP "BUTTON"
                // **************************************************************
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Already have an account?"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: const Text(
                          "Sign in.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
