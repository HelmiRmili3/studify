import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:studify/models/matiere.dart';

class StorageRepository {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<List<FileEntity>> uploadFiles(
    List<File> files,
    String collectionName,
  ) async {
    try {
      List<FileEntity> fileMetadataList = [];
      for (File file in files) {
        final fileMetadata =
            await _uploadToFirebaseStorage(file, collectionName);
        fileMetadataList.add(fileMetadata);
      }

      return fileMetadataList;
    } catch (e) {
      debugPrint("Error uploading files: $e");
      rethrow;
    }
  }

  Future<FileEntity> uploadFile(File file, String collectionName) async {
    try {
      final fileMetadata = await _uploadToFirebaseStorage(file, collectionName);
      return fileMetadata;
    } catch (e) {
      debugPrint("Error uploading file: $e");
      rethrow;
    }
  }

  Future<FileEntity> _uploadToFirebaseStorage(
      File file, String collectionName) async {
    final fileName = file.path.split('/').last;
    final storageReference =
        _firebaseStorage.ref().child('$collectionName/$fileName');

    final uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => null);

    final fileUrl = await storageReference.getDownloadURL();

    return FileEntity.fromJson({
      'filename': fileName,
      'filepath': fileUrl,
    });
  }
}
