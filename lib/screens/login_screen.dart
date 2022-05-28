import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:identity_project/responsive/mobile_screen_layout.dart';
import 'package:identity_project/responsive/responsive_layout_screen.dart';
import 'package:identity_project/responsive/web_screen_layout.dart';
import 'package:identity_project/screens/signup_screen.dart';
import 'package:identity_project/utils/colors.dart';
import 'package:identity_project/utils/global_variables.dart';
import 'package:identity_project/utils/utils.dart';
import 'package:identity_project/widgets/image_logo.dart';
import 'package:identity_project/widgets/loader.dart';
import 'package:identity_project/widgets/text_input_field.dart';

import '../resources/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  final bool comeFromRegister;

  const LoginScreen({Key? key, required this.comeFromRegister})
      : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Creamos controllers para pasar a los inputs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;
  num limitMessageErrorFix = 0;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void logInUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().logInUser(
      email: _emailController.text,
      password: _passController.text,
    );

    if (res == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });

      showCustomErrorDialog(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void redirectToRegister() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  void redirectToHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    /**
     * Se utiliza esta instancia porque en caso de que esté un dato pasado
     * se lee antes de que se finalice el build.
     * Por eso se utiliza este callback. Para ejecutar este trozo de código
     * cuando se hayan cargado los datos.
     */

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Si el usuario se acaba de registar , mostrar toast de registro completado
      if (widget.comeFromRegister) {
        if (limitMessageErrorFix == 0) {
          showSnackBar('User registered successfully', context, false);
          setState(() {
            limitMessageErrorFix++;
          });
        }
      }
      limitMessageErrorFix++;
    });

    return KeyboardDismissOnTap(
        child: Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 1),
              //svg logo
              ImageLogo(
                height: -1,
                logoType: 'default',
                textColor: 'default',
              ),
              //Inputs of email and password
              TextInputField(
                controller: _emailController,
                hint: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              // MARGIN BETWEEN INPUTS
              const SizedBox(height: 27),
              // MARGIN BETWEEN INPUTS
              TextInputField(
                controller: _passController,
                hint: 'Enter your password',
                isPass: true,
                textInputType: TextInputType.text,
              ),
              // MARGIN BETWEEN INPUTS AND BUTTON
              const SizedBox(height: 27),
              // MARGIN BETWEEN INPUTS AND BUTTON
              //Button of login
              InkWell(
                onTap: logInUser,
                child: _isLoading
                    ? Stack(
                        children: const [
                          Center(child: Loader(height: 175, width: 175)),
                          Center(
                            child: Text(
                              'Loging in...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        child: const Text(
                          'Log in',
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
              // MARGIN BETWEEN INPUTS AND BUTTON
              const SizedBox(height: 27),
              // MARGIN BETWEEN INPUTS AND BUTTON
              Flexible(child: Container(), flex: 2),

              //Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                  ),
                  GestureDetector(
                    onTap: redirectToRegister,
                    child: Container(
                      child: const Text(
                        "Sign up.",
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
    ));
  }
}
