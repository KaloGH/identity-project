import 'package:flutter/material.dart';
import 'package:identity_project/utils/colors.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hint;
  final TextInputType textInputType;

  const TextInputField(
      {Key? key,
      required this.controller,
      this.isPass = false,
      required this.hint,
      required this.textInputType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          fillColor: primaryColor), // InputDecoration
      keyboardType: textInputType,
      obscureText: isPass,
    ); // TextField
  }
}
