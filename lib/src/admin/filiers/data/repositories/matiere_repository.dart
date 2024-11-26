import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/utils/firestore.dart';
import '../../../../../models/matiere.dart';

class MatiereRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  /// Add a new `Matiere` to the Firestore database
  Future<void> addMatiere(Matiere matiere) async {
    try {
      await _firestore
          .collection(Firestore.years)
          .doc('2024')
          .collection('matieres')
          .doc(matiere.id)
          .set(matiere.toJson());
    } catch (e) {
      throw Exception('Error adding matiere: $e');
    }
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
  Future<void> updateMatiere(Matiere matiere) async {
    try {
      await _firestore
          .collection(Firestore.years)
          .doc('2024')
          .collection('matieres')
          .doc(matiere.id)
          .update(matiere.toJson());
    } catch (e) {
      throw Exception('Error updating matiere: $e');
    }
  }
}
