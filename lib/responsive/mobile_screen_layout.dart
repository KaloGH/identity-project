import 'package:flutter/material.dart';
import 'package:identity_project/models/user.dart' as model;
import 'package:identity_project/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        body: Center(
      child: Text(
        user.username,
        style: const TextStyle(
          color: Colors.blue,
        ),
      ),
    ));
  }
}
