import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:studify/core/utils/firestore.dart';
import 'package:studify/models/matiere.dart';
import 'package:uuid/uuid.dart';
import '../../../models/user.dart';
import '../../../src/common/auth/data/models/user_update_model.dart';
import '../../storage_repository.dart';
import '../../utils/enums.dart';

class UserRepository extends StorageRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?> getUser() async {
    final User? user = _firebaseAuth.currentUser;
    if (user == null) {
      debugPrint("No user is currently signed in.");
      return null;
    }
    try {
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore.collection(Firestore.users).doc(user.uid).get();
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

  Future<void> addAdmin(String email) async {
    final collectionRef = _firestore.collection(Firestore.emails);

    try {
      await collectionRef.where('email', isEqualTo: email).get();
      // if (querySnapshot.docs.isNotEmpty) {
      //   debugPrint('======================> Admin Email already exists!');
      //   return;
      // }
      final uuid = const Uuid().v4();
      await collectionRef.doc(uuid).set({
        'email': email,
        'id': uuid,
        'role': UserRole.admin.index,
      });
      // debugPrint('======================> Admin Email added successfully!');
    } catch (e) {
      debugPrint('An error occurred while adding the admin email: $e');
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
      UserUpdateModel updatedUser = user;
      if (newImage != null) {
        String imageUrl;
        FileEntity imageUploadResult =
            await uploadFile(File(newImage.filepath), 'images');
        imageUrl = imageUploadResult.filepath;

        updatedUser = user.copyWith(imageUrl: imageUrl);
      }

      await _firestore
          .collection(Firestore.users)
          .doc(currentUser.uid)
          .update(updatedUser.toJson());
      await _firestore
          .collection(Firestore.years)
          .doc('2024')
          .collection(Firestore.authenticated)
          .doc(currentUser.uid)
          .set({
        'uid': currentUser.uid,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'imageUrl': user.imageUrl
      });

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
}
