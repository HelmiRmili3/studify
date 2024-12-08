import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:studify/models/filiere.dart';
import 'package:studify/models/matiere.dart';

import '../../../../../core/utils/firestore.dart';

class HomeRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<List<Matiere>> streamMatieres() {
    try {
      // Get the current user's UID
      String userId = _firebaseAuth.currentUser?.uid ?? '';

      // Stream the Matieres where professor matches the user's UID
      return _firebaseFirestore
          .collection(Firestore.years)
          .doc('2024')
          .collection(Firestore.matieres)
          .where('professor', isEqualTo: userId) // Apply the filter
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return Matiere.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      debugPrint("Error streaming matieres: $e");
      return const Stream.empty(); // Return an empty stream on error
    }
  }

  Stream<List<Filiere>> streamFilieres() {
    try {
      // Get the current user's UID
      String userId = _firebaseAuth.currentUser?.uid ?? '';

      // Stream the matieres collection for the professor
      return _firebaseFirestore
          .collection(Firestore.years)
          .doc('2024')
          .collection(Firestore.matieres)
          .where('professor', isEqualTo: userId)
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) async {
        List<Filiere> uniqueFilieres = [];

        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          DocumentSnapshot filiereDoc = await _firebaseFirestore
              .collection(Firestore.years)
              .doc('2024')
              .collection(Firestore.niveaux)
              .doc(data['filiere'] as String)
              .get();

          if (filiereDoc.exists) {
            Filiere filiere =
                Filiere.fromJson(filiereDoc.data() as Map<String, dynamic>);

            // Check for duplicate based on filiere.code
            if (!uniqueFilieres.any((f) => f.code == filiere.code)) {
              uniqueFilieres.add(filiere);
            }
          }
        }

        return uniqueFilieres;
      });
    } catch (e) {
      debugPrint("Error streaming filieres: $e");
      return const Stream.empty(); // Return an empty stream on error
    }
  }
}
