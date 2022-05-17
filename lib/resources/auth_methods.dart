import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:identity_project/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // **************************************************************
  //                    SIGN UP USER
  // **************************************************************
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List file, // Latter we will use Uint8List and not File
  }) async {
    String res = "Some error ocurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        // If they are not empty , create user
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profile_images', file, false);

        // To store all info we have , we store the user in our database
        // We create collection and doc if not exist and set the data in this doc.
        _firestore.collection('users').doc(credentials.user!.uid).set({
          'username': username,
          'uid': credentials.user!.uid,
          'email': email,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // **************************************************************
  //                    SIGN IN USER
  // **************************************************************
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error ocurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
