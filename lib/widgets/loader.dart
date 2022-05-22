import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  final double width;
  final double height;

  const Loader({Key? key, required this.width, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/json/loading.json',
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
    // TextField
  }
}
