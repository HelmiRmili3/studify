import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../../../../core/utils/firestore.dart';
import '../../../../../models/filiere.dart';

class FiliereRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
      return const Stream.empty(); // Return an empty stream on error
    }
  }

  Future<void> addFiliere(Filiere filiere) async {
    try {
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
            .set(filiere.toJson());
      }

      debugPrint("Filiere and its niveaux added successfully!");
    } catch (e) {
      debugPrint("Error adding filiere: $e");
    }
  }

  Future<void> updateFiliere(Filiere updatedFiliere) async {
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
}
