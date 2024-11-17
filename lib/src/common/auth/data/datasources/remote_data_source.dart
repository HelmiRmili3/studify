import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../models/file_item.dart';
import '../../domain/entities/user_email_entity.dart';
import '../../domain/entities/user_login_entity.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../models/user_profile_model.dart';
import '../models/user_register_model.dart';

abstract class RemoteDataSource {
  // Auth functions for all users
  Future<UserCredential?> login(UserLoginEntity user);
  Future<UserCredential?> register(UserRegisterModel user);
  Future<UserProfileEntity?> getUser(String userId);

  Future<UserProfileEntity?> updateUser(UserProfileModel user);
  Future<UserEmailEntity?> checkUserAuthorization(String email);
  Future<void> addUserToFirestore(UserProfileModel user);
  Future<Map<String, dynamic>> uploadImageToFirebaseStorage(File? imageFile);
  Future<FileItem> addFileToFirestore(FileItem file);
}
