import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:identity_project/models/post.dart';
import 'package:identity_project/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /**
   * 
   * Upload post
   */
  Future<String> uploadPost(String caption, Uint8List file, String uid,
      String username, String profileImage) async {
    String res = 'Something went wrong';

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
          caption: caption,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profileImage: profileImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = 'Success';
    } catch (error) {
      res = error.toString();
    }

    return res;
  }
}
