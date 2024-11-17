import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:uuid/uuid.dart';

import '../../../../../models/file_item.dart';
import '../../domain/entities/user_email_entity.dart';
import '../../domain/entities/user_login_entity.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../models/user_profile_model.dart';
import '../models/user_register_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<UserCredential?> login(UserLoginEntity user) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return result;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  Future<UserCredential?> register(UserRegisterModel user) async {
    try {
      final result = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      )
          .then((_) async {
        // Check if user has an image, else load the default image from assets
        File imageFile;
        if (user.image == null) {
          // Load the default image from assets
          final byteData =
              await rootBundle.load('assets/images/default_avatar.jpg');
          final file = File(
              '${(await getTemporaryDirectory()).path}/default_avatar.jpg');
          await file.writeAsBytes(byteData.buffer.asUint8List());
          imageFile = file;
        } else {
          // Use the provided image if not null
          imageFile = user.image!;
        }

        // Upload image to Firebase Storage
        return uploadImageToFirebaseStorage(imageFile);
      }).then((filedata) async {
        // Add file data to Firestore
        return addFileToFirestore(
          FileItem(
            fileId: const Uuid().v1(),
            fileName: filedata['name'],
            fileUrl: filedata['imageUrl'],
            uploadDate: DateTime.now(),
          ),
        );
      }).then((file) async {
        // Create the user profile with the uploaded image URL
        UserProfileModel userProfile = UserProfileModel(
          uid: user.uid,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          password: user.password,
          createdAt: user.createdAt,
          updatedAt: user.updatedAt,
          birthDay: user.birthDay,
          phoneNumber: user.phoneNumber,
          role: UserRole.admin,
          sexe: user.sexe,
          imageUrl: file.fileUrl,
        );

        // Add user to Firestore
        await addUserToFirestore(userProfile);
      });

      return result;
    } catch (e) {
      print("Registration Error: $e");
      return null;
    }
  }

  Future<UserProfileEntity?> updateUser(UserProfileModel user) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .update(user.toJson());
      return user; // Return updated user
    } catch (e) {
      print("Update Error: $e");
      return null;
    }
  }

  Future<UserEmailEntity?> checkUserAuthorization(String email) async {
    try {
      final doc =
          await _firebaseFirestore.collection('emails').doc(email).get();
      if (doc.exists) {
        return doc.data()! as UserEmailEntity;
      }
      return null;
    } catch (e) {
      print("Authorization Check Error: $e");
      return null;
    }
  }

  Future<UserProfileEntity?> getUser(String userId) async {
    try {
      final doc =
          await _firebaseFirestore.collection('users').doc(userId).get();
      return UserProfileModel.fromJson(doc.data()!);
    } catch (e) {
      print("Get User Error: $e");
      return null;
    }
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
      await _firebaseFirestore.collection('users').doc(user.uid).set(userData);
    } catch (e) {
      print("Error adding user to Firestore: $e");
    }
  }
}
