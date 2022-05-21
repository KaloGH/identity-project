import 'package:flutter/material.dart';
import 'package:identity_project/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home Screen',
        style: TextStyle(color: primaryColor),
      ),
    );
  }
}
