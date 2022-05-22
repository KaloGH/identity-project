import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:identity_project/resources/storage_methods.dart';
import 'package:identity_project/utils/utils.dart';

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
    required Uint8List file,
  }) async {
    String res = "Some error ocurred";
    const String defaultBioMessage =
        'Im new in iDentity App. I didn\'t change my biography yet. Just give me some time :) ';
    try {
      if (file == null) {
        //showSnackBar('Please upload a photo', context);
        throw FirebaseAuthException(
            message: 'Please upload photo.', code: 'no-photo');
      }

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
          'bio': defaultBioMessage,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        res = 'success';
      }
    } on FirebaseAuthException catch (error) {
      res = getErrorMessage(error.code);
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
      // if (email.isNotEmpty || password.isNotEmpty) {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
      // }
    } on FirebaseAuthException catch (error) {
      res = getErrorMessage(error.code);
    }

    return res;
  }
}
