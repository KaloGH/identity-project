import 'package:flutter/material.dart';
import 'package:identity_project/models/user.dart';
import 'package:identity_project/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get getUser => _user!;

  Future<void> refreshUser() async {
    final user = await AuthMethods().getUserDetails();
    _user = user;
    notifyListeners();
  }
}
