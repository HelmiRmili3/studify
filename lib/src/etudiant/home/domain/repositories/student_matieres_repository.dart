import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studify/models/user.dart';

import '../../../../../core/utils/enums.dart';
import '../../../../../core/utils/firestore.dart';
import '../../../../../models/matiere.dart';
import '../../../../common/auth/data/models/user_profile_model.dart';

class StudentMatieresRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<List<Matiere>> streamMatieres() async* {
    try {
      // Get the current user ID
      String userId = _firebaseAuth.currentUser?.uid ?? '';

      // Fetch the user's 'filiere' data
      DocumentSnapshot filiereDoc = await _firebaseFirestore
          .collection('years')
          .doc('2024')
          .collection(Firestore.access)
          .doc(userId)
          .get();

      // Ensure the document exists and has a 'filiere' field
      if (filiereDoc.exists && filiereDoc.data() != null) {
        Map<String, dynamic> filier = filiereDoc.data() as Map<String, dynamic>;
        String userFiliere = filier['filiere'];

        // Stream the matieres collection filtered by 'filiere'
        yield* _firebaseFirestore
            .collection(Firestore.years)
            .doc('2024')
            .collection(Firestore.matieres)
            .where('filiere', isEqualTo: userFiliere)
            .snapshots()
            .asyncMap((QuerySnapshot querySnapshot) {
          return querySnapshot.docs.map((doc) {
            return Matiere.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();
        });
      } else {
        debugPrint("Filiere document doesn't exist or is invalid.");
        yield [];
      }
    } catch (e) {
      debugPrint("Error streaming matieres: $e");
      yield [];
    }
  }

  Stream<List<UserModel>> streamProfessors() async* {
    try {
      // Fetch the niveaux document to get the list of student IDs
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection(Firestore.years)
              .doc('2024')
              .collection(Firestore.niveaux)
              .doc('LISI1')
              .get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        List<dynamic> studentIds =
            docSnapshot.data()!['emails'] as List<dynamic>;

        List<Future<UserModel?>> emailFutures = studentIds.map((id) async {
          DocumentSnapshot<Map<String, dynamic>> userSnapshot =
              await FirebaseFirestore.instance
                  .collection(Firestore.users)
                  .doc(id)
                  .get();
          UserModel userData = UserModel.fromMap(userSnapshot.data()!);
          if (userSnapshot.exists && userSnapshot.data() != null) {
            if (userData.role == UserRole.professor) {
              return userData;
            } else {
              return null;
            }
          } else {
            return null;
          }
        }).toList();

        // Resolve futures and filter out null values
        List<UserModel?> emailModels = await Future.wait(emailFutures);
        List<UserModel> validEmailModels =
            emailModels.whereType<UserModel>().toList();

        yield validEmailModels;
      } else {
        yield [];
      }
    } catch (e) {
      debugPrint("Error fetching emails as stream: $e");
      yield [];
    }
  }

  Future<UserProfileModel?> getFiliere(String userId) async {
    try {
      final doc = await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('users')
          .doc(userId)
          .get();
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
}
