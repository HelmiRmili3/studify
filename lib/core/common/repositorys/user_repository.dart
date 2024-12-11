import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:studify/models/matiere.dart';
import '../../../models/user.dart';
import '../../../src/common/auth/data/models/user_update_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Future<UserModel?> getUser() async {
    final User? user = _firebaseAuth.currentUser;
    if (user == null) {
      debugPrint("No user is currently signed in.");
      return null;
    }
    try {
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore.collection('users').doc(user.uid).get();
      if (docSnapshot.exists) {
        return UserModel.fromMap(docSnapshot.data()!);
      } else {
        debugPrint("User document does not exist.");
        return null;
      }
    } catch (e) {
      debugPrint("Error getting user: $e");
      return null;
    }
  }

  Future<UserModel?> updateUser(
      UserUpdateModel user, FileEntity? newImage) async {
    final User? currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      debugPrint("No user is currently signed in.");
      return null;
    }

    try {
      String? imageUrl;
      if (newImage != null && newImage.filepath.isNotEmpty) {
        final imageUploadResult =
            await uploadImageToFirebaseStorage(File(newImage.filepath));
        imageUrl = imageUploadResult['imageUrl'];
      }

      // Update user information with the new image URL if uploaded
      final updatedUser = user.copyWith(imageUrl: imageUrl ?? user.imageUrl);
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .update(updatedUser.toJson());

      // Retrieve the updated user
      UserModel? updatedUserModel = await getUser();
      if (updatedUserModel != null) {
        return updatedUserModel;
      }

      debugPrint("Failed to fetch updated user.");
      return null;
    } catch (e) {
      debugPrint("Error updating user: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> uploadImageToFirebaseStorage(
      File? imageFile) async {
    if (imageFile == null || imageFile.path.isEmpty) return {};
    try {
      String name = imageFile.path.split('/').last;

      final Reference storageReference =
          _firebaseStorage.ref().child('images/$name');
      final UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() => null);

      final String imageUrl = await storageReference.getDownloadURL();
      return {
        'name': name,
        'imageUrl': imageUrl,
      };
    } catch (e) {
      debugPrint("Error uploading image: $e");
      return {};
    }
  }
}
