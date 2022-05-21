import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }

  print('No image selected');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

String getErrorMessage(String errorCode) {
  String errorString = '';
  switch (errorCode) {
    case "unknown":
      errorString =
          'Some of the fields aren\'t filled. Please fill all fields.';
      break;

    case "invalid-email":
      errorString =
          'The email written is invalid or wrong formatted. Must be like "example@email.com"';
      break;

    case "user-not-found":
      errorString =
          'User not found. If you don\'t have account, you can create one by clicking in Sign Up';
      break;

    case "wrong-password":
      errorString =
          'The username or password are wrong.Please try to remember them.';
      break;

    case "invalid-password":
      errorString = 'The password must contain at least 6 characters';
      break;

    case "weak-password":
      errorString =
          'The password is too weak, must contain at least 6 characters';
      break;

    case "email-already-in-use":
      errorString =
          'This email already exists. Please change the email and try again.';
      break;

    default:
      errorString = errorCode;
  }
  return errorString;
}
