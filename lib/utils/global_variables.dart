import 'package:flutter/material.dart';
import 'package:identity_project/screens/add_post_screen.dart';

const webScreenSize = 600;

const appScreens = [
  Center(
    child: Text(
      'Home',
      style: TextStyle(fontSize: 32),
    ),
  ),
  Center(
    child: Text(
      'Search',
      style: TextStyle(fontSize: 32),
    ),
  ),
  AddPostScreen(),
  Center(
    child: Text(
      'Favorites',
      style: TextStyle(fontSize: 32),
    ),
  ),
  Center(
    child: Text(
      'Profile',
      style: TextStyle(fontSize: 32),
    ),
  ),
];
