import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:studify/models/new_filiere.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/utils/firestore.dart';
import '../../../../../models/file_item.dart';
import '../../../../../models/filiere.dart';
import '../../../../../models/matiere.dart';

class FiliereRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Stream<List<Filiere>> streamFilieres() {
    try {
      return _firebaseFirestore
          .collection(Firestore.years)
          .doc('2024')
          .collection(Firestore.filieres)
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return Filiere.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      debugPrint("Error streaming filieres: $e");
      return const Stream.empty();
    }
  }

  Future<void> addFiliere(
    NewFiliere filiere,
    File? image,
  ) async {
    try {
      // Upload the image to Firebase Storage
      final imagedata = await _uploadAndSaveFile(image!);

      for (int niveau = 1; niveau <= filiere.nbYears; niveau++) {
        // Create the document reference for the Niveau
        final niveauDocRef = _firebaseFirestore
            .collection(Firestore.years)
            .doc('2024')
            .collection(Firestore.niveaux)
            .doc("${filiere.code}$niveau");

        // Add the document to the Niveaux collection
        await niveauDocRef.set({
          "code": '${filiere.code}$niveau',
          "filiere": filiere.filiere,
          'nbYears': filiere.nbYears,
          "year": niveau,
          "imageUrl": imagedata.fileUrl,
          "emails": [],
        });

        // Add the reference to the filiere collection
        await _firebaseFirestore
            .collection(Firestore.years)
            .doc('2024')
            .collection(Firestore.filieres)
            .doc(filiere.code)
            .collection(Firestore.niveaux)
            .doc("${filiere.code}$niveau")
            .set({
          'docRef': niveauDocRef.path,
        });
        await _firebaseFirestore
            .collection(Firestore.years)
            .doc('2024')
            .collection(Firestore.filieres)
            .doc(filiere.code)
            .set(filiere.copyWith(image: imagedata.fileUrl).toJson());
      }

      debugPrint("Filiere and its niveaux added successfully!");
    } catch (e) {
      debugPrint("Error adding filiere: $e");
    }
  }

  Future<void> updateFiliere(NewFiliere updatedFiliere) async {
    try {
      _firebaseFirestore
          .collection(Firestore.years)
          .doc('2024')
          .collection(Firestore.filieres)
          .doc(updatedFiliere.code)
          .update(updatedFiliere.toJson());
    } catch (e) {}
  }

  Future<void> deleteFiliere(String code) async {
    try {
      _firebaseFirestore
          .collection(Firestore.years)
          .doc('2024')
          .collection(Firestore.filieres)
          .doc(code)
          .delete();
    } catch (e) {}
  }

  Future<FileItem> _uploadAndSaveFile(File imageFile) async {
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
    return fileItem;
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

    await _firebaseFirestore
        .collection('files')
        .doc(file.fileId)
        .set(filedata.toJson());
    return filedata;
  }
}
