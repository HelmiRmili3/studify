import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:studify/core/utils/firestore.dart';
import 'package:studify/src/common/auth/domain/entities/user_email_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../../models/file_item.dart';
import '../../domain/entities/user_login_entity.dart';
import '../models/user_profile_model.dart';
import '../models/user_register_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<UserCredential?> login(UserLoginEntity userdata) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: userdata.email.trim(),
        password: userdata.password.trim(),
      );

      UserProfileModel? userProfile = await getUser(result.user!.uid);
      debugPrint("User Profile: $userProfile");
      return result;
    } catch (e) {
      debugPrint("Login Error: $e");
      return null;
    }
  }

  Future<UserProfileModel?> getUser(String userId) async {
    try {
      final doc =
          await _firebaseFirestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return UserProfileModel.fromJson(doc.data()!);
      } else {
        debugPrint("User not found or document is empty");
        return null;
      }
    } catch (e) {
      debugPrint("Get User Error: $e");
      return null;
    }
  }

  Future<void> logout() async {
    try {
      final result = await _firebaseAuth.signOut();
      return result;
    } catch (e) {
      debugPrint("Login Error: $e");
    }
  }

  Future<UserCredential?> register(UserRegisterModel user) async {
    try {
      final UserEmailEntity? userExised =
          await checkUserAuthorization(user.email);
      debugPrint(" ===================>  User Existed : $userExised");

      if (userExised == null) {
        debugPrint(" ===================>  Email not Authorized");
        return null;
      }
      late UserCredential userdata;
      final result = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      )
          .then((userCredential) async {
        // Assign user credential
        userdata = userCredential;

        // Define a variable to hold the image file
        File imageFile;

        // Check if the user has an image
        if (user.image == null) {
          // Load the default avatar image from assets
          final byteData =
              await rootBundle.load('assets/images/default_avatar.jpg');

          // Create a temporary file path for the default avatar
          final tempDir = await getTemporaryDirectory();
          final defaultAvatarPath = '${tempDir.path}/default_avatar.jpg';

          // Write the default avatar data to the temporary file
          final file = File(defaultAvatarPath);
          await file.writeAsBytes(byteData.buffer.asUint8List());

          // Assign the default avatar to imageFile
          imageFile = file;
        } else {
          // Use the user's provided image
          imageFile = File(user.image!.filepath);
        }

        // Upload the image file to Firebase Storage and return the result
        return uploadImageToFirebaseStorage(imageFile);
      }).then((filedata) async {
        return addFileToFirestore(
          FileItem(
            fileId: const Uuid().v1(),
            fileName: filedata['name'],
            fileUrl: filedata['imageUrl'],
            uploadDate: DateTime.now(),
          ),
        );
      }).then((file) async {
        UserProfileModel userProfile = UserProfileModel(
          uid: userdata.user!.uid,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          createdAt: user.createdAt,
          updatedAt: user.updatedAt,
          birthDay: user.birthDay,
          phoneNumber: user.phoneNumber,
          role: userExised.role,
          sexe: user.sexe,
          imageUrl: file.fileUrl,
        );
        await addUserToFirestore(userProfile);
        // await _firebaseFirestore
        //     .collection(Firestore.emails)
        //     .doc(userExised.id)
        //     .delete();
      });

      return result;
    } catch (e, stackTrace) {
      debugPrint("Error deleting user: $e");
      debugPrint("Stack Trace: $stackTrace");
      return null;
    }
  }

  // Future<void> updateUserEmail(UserEmailEntity email) async {
  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection('emails')
  //         .where('email', isEqualTo: email.email)
  //         .get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       final doc = querySnapshot.docs.first;
  //       final String id = doc['id'] as String;
  //       await FirebaseFirestore.instance.collection('emails').doc(id).delete();
  //       debugPrint("email deleted with id : $id");
  //       await _firebaseFirestore.collection('emails').doc(email.id).set({
  //         'id': email.id,
  //         'email': email.email,
  //         'role': email.role,
  //       });

  //       debugPrint("email deleted with id : ${email.id}");
  //     }
  //   } catch (e) {
  //     debugPrint("error : $e");
  //   }
  // }

  // Future<UserProfileEntity?> updateUser(UserProfileModel user) async {
  //   try {
  //     await _firebaseFirestore
  //         .collection('users')
  //         .doc(user.uid)
  //         .update(user.toJson());
  //     return user; // Return updated user
  //   } catch (e) {
  //     debugPrint("Update Error: $e");
  //     return null;
  //   }
  // }

  Future<UserEmailEntity?> checkUserAuthorization(String email) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('emails')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final int roleInt = doc['role'];

        UserRole userRole;
        switch (roleInt) {
          case 0:
            userRole = UserRole.admin;
            break;
          case 1:
            userRole = UserRole.professor;
            break;
          case 2:
            userRole = UserRole.student;
            break;
          default:
            userRole = UserRole.unknown;
            break;
        }

        return UserEmailEntity(
          id: doc.id,
          email: doc['email'],
          role: userRole,
        );
      }
    } catch (e) {
      debugPrint("Authorization Check Error: $e");
    }

    return null;
  }

  Future<Map<String, dynamic>> uploadImageToFirebaseStorage(
      File? imageFile) async {
    if (imageFile == null) return {};
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
  }

  Future<FileItem> addFileToFirestore(FileItem file) async {
    final filedata = {
      'fileId': file.fileId,
      'fileName': file.fileName,
      'fileUrl': file.fileUrl,
      'uploadDate': file.uploadDate,
    };

    await _firebaseFirestore.collection('files').doc(file.fileId).set(filedata);
    return file;
  }

  Future<void> addUserToFirestore(UserProfileModel user) async {
    final userData = {
      'email': user.email,
      'uid': user.uid,
      'createdAt': user.createdAt,
      'updatedAt': user.updatedAt,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'phoneNumber': user.phoneNumber,
      'sexe': user.sexe.index,
      'birthDay': user.birthDay,
      'imageUrl': user.imageUrl,
      'role': user.role.index,
    };
    try {
      await _firebaseFirestore
          .collection(Firestore.users)
          .doc(user.uid)
          .set(userData);
      try {} catch (e) {
        debugPrint("Error adding user to Firestore: $e");
      }
      await _firebaseFirestore
          .collection(Firestore.years)
          .doc('2024')
          .collection(Firestore.authenticated)
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
        'role': user.role.index,
        'imageUrl': user.imageUrl,
      });
    } catch (e) {
      debugPrint("Error adding user to Firestore: $e");
    }
  }
}
