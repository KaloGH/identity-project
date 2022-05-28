import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:identity_project/screens/add_post_screen.dart';
import 'package:identity_project/screens/favourite_screen.dart';
import 'package:identity_project/screens/feed_screen.dart';
import 'package:identity_project/screens/profile_screen.dart';
import 'package:identity_project/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> appScreens = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const FavouriteScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
