import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:identity_project/utils/colors.dart';
import 'package:identity_project/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Creamos controllers para pasar a los inputs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dependiendo si es escritorio o móvil, cargamos un logo u otro
    final StatefulWidget logo;
    if (kIsWeb) {
      logo = SvgPicture.asset(
        'svg/logo_white.svg',
        height: 350,
      );
    } else {
      logo = Image.asset(
        'assets/images/logo_white.png',
        height: 350,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 1),
              //svg logo
              logo,
              const SizedBox(
                height: 34,
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
                child: Container(
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
                        Radius.circular(5),
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
                    onTap: () {},
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
    );
  }
}
