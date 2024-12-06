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
          .map((QuerySnapshot querySnapshot) {
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

      // Stream the access document for the user
      return _firebaseFirestore
          .collection(Firestore.years)
          .doc('2024')
          .collection(Firestore.access)
          .doc(userId)
          .snapshots()
          .asyncMap((DocumentSnapshot snapshot) async {
        if (snapshot.exists) {
          // Safely cast the snapshot data to a Map
          final data = snapshot.data() as Map<String, dynamic>;

          // Get the list of filiere codes
          List<String> filiereCodes = List<String>.from(data['filieres'] ?? []);

          // Fetch filiere data for each code
          List<Filiere> filieres = [];
          for (String code in filiereCodes) {
            DocumentSnapshot filiereDoc = await _firebaseFirestore
                .collection(Firestore.years)
                .doc('2024')
                .collection(Firestore.niveaux)
                .doc(code)
                .get();

            if (filiereDoc.exists) {
              filieres.add(
                  Filiere.fromJson(filiereDoc.data() as Map<String, dynamic>));
            }
          }
          return filieres;
        } else {
          return []; // Return an empty list if the document doesn't exist
        }
      });
    } catch (e) {
      debugPrint("Error streaming filieres: $e");
      return const Stream.empty(); // Return an empty stream on error
    }
  }
}
