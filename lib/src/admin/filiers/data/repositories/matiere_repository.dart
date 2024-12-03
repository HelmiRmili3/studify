import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studify/models/user.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/utils/firestore.dart';
import '../../../../../models/file_item.dart';
import '../../../../../models/matiere.dart';

class MatiereRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  /// Fetch a stream of all `Matiere` objects
  Stream<List<Matiere>> fetchMatieres(niveau) {
    return _firestore
        .collection(Firestore.years)
        .doc('2024')
        .collection(Firestore.matieres)
        .where('filiere', isEqualTo: niveau)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Matiere.fromDocument(doc)).toList();
    });
  }

  Future<UserModel> getUserById(String id) async {
    try {
      final doc = await _firestore
          .collection(Firestore.years)
          .doc('2024')
          .collection(Firestore.users)
          .doc(id)
          .get();
      if (!doc.exists) {
        throw Exception('User not found');
      }
      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  /// Add a new `Matiere` to the Firestore database
  Future<void> addMatiere(Matiere matiere) async {
    try {
      // Get the image file (either user-provided or default)
      File imageFile = await _getImageFile(matiere.coverPhoto);

      // Upload the image to Firebase Storage
      FileEntity file = await _uploadAndSaveFile(imageFile);

      // Save the Matiere to Firestore
      await _saveMatiereToFirestore(matiere, file);
    } catch (e) {
      debugPrint("Error adding Matiere: $e");
      throw Exception('Error adding Matiere: $e');
    }
  }

  /// Get the image file (either user-provided or default)
  Future<File> _getImageFile(FileEntity? coverPhoto) async {
    if (coverPhoto == null) {
      debugPrint("No image provided. Using default avatar.");
      return _loadDefaultAvatar();
    } else {
      debugPrint("Using user-provided image: ${coverPhoto.filepath}");
      return File(coverPhoto.filepath);
    }
  }

  /// Load the default avatar from assets
  Future<File> _loadDefaultAvatar() async {
    final byteData = await rootBundle.load('assets/images/default_avatar.jpg');
    final tempDir = await getTemporaryDirectory();
    final defaultAvatarPath = '${tempDir.path}/default_avatar.jpg';
    final file = File(defaultAvatarPath);
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  /// Upload the image to Firebase Storage and save the file details
  Future<FileEntity> _uploadAndSaveFile(File imageFile) async {
    final fileData = await uploadImageToFirebaseStorage(imageFile);
    if (fileData == null) {
      throw Exception("File upload failed.");
    }
    debugPrint("File uploaded: $fileData");

    final fileItem = FileItem(
      fileId: const Uuid().v1(),
      fileName: fileData.filename,
      fileUrl: fileData.filepath,
      uploadDate: DateTime.now(),
    );

    await addFileToFirestore(fileItem);
    return fileData;
  }

  /// Save the Matiere to Firestore
  Future<void> _saveMatiereToFirestore(Matiere matiere, FileEntity file) async {
    await _firestore
        .collection(Firestore.years)
        .doc('2024')
        .collection('matieres')
        .doc(matiere.id)
        .set(Matiere(
          id: matiere.id,
          name: matiere.name,
          professor: matiere.professor,
          raitings: matiere.raitings,
          favorites: matiere.favorites,
          filiere: matiere.filiere,
          description: matiere.description,
          part: matiere.part,
          coefficient: matiere.coefficient,
          type: matiere.type,
          coverPhoto: file,
        ).toJson());

    debugPrint("Matiere saved to Firestore with ID: ${matiere.id}");
  }

  /// Get a specific `Matiere` by its ID
  Future<Matiere?> getMatiereById(String id) async {
    try {
      final doc = await _firestore
          .collection(Firestore.years)
          .doc('2024')
          .collection('matieres')
          .doc(id)
          .get();
      if (doc.exists) {
        return Matiere.fromDocument(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Error fetching matiere: $e');
    }
  }

  /// Delete a `Matiere` by its ID
  Future<void> deleteMatiere(String id) async {
    try {
      await _firestore
          .collection(Firestore.years)
          .doc('2024')
          .collection('matieres')
          .doc(id)
          .delete();
    } catch (e) {
      throw Exception('Error deleting matiere: $e');
    }
  }

  /// Update a specific `Matiere`
  Future<Matiere> updateMatiere(Matiere matiere) async {
    try {
      await _firestore
          .collection(Firestore.years)
          .doc('2024')
          .collection('matieres')
          .doc(matiere.id)
          .update(matiere.toJson());
      final doc = await _firestore
          .collection(Firestore.years)
          .doc('2024')
          .collection('matieres')
          .doc(matiere.id)
          .get();
      debugPrint("Matiere updated in Firestore with ID: ${matiere.id}");
      return Matiere.fromDocument(doc);
    } catch (e) {
      throw Exception('Error updating matiere: $e');
    }
  }

  Future<FileEntity?> uploadImageToFirebaseStorage(File imageFile) async {
    String name = imageFile.path.split('/').last;
    final Reference storageReference =
        _firebaseStorage.ref().child('images/$name');
    final UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.whenComplete(() => null);
    final String imageUrl = await storageReference.getDownloadURL();
    return FileEntity(filename: name, filepath: imageUrl);
  }

  Future<FileItem> addFileToFirestore(FileItem file) async {
    final filedata = FileItem(
      fileId: file.fileId,
      fileName: file.fileName,
      fileUrl: file.fileUrl,
      uploadDate: file.uploadDate,
    );

    await _firestore
        .collection('files')
        .doc(file.fileId)
        .set(filedata.toJson());
    return filedata;
  }
}
