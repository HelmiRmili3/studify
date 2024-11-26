// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// import '../../../../../models/filiere.dart';

// import '../../../../common/auth/domain/entities/user_email_entity.dart';

// class AdminFiliersRepository {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

//   Future<List<String>?> getFiliers() async {
//     try {
//       final QuerySnapshot<Map<String, dynamic>> snapshot =
//           await _firebaseFirestore.collection('filiers').get();
//       final List<String> filiers = snapshot.docs.map((doc) {
//         return doc.id;
//       }).toList();
//       return filiers;
//     } catch (e) {
//       debugPrint('Error getting filiers: $e');
//     }
//   }

//   Future<void> getFilierByCode(String filierCode) async {
//     try {
//       final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
//           await _firebaseFirestore.collection('filiers').doc(filierCode).get();
//       final List<String> filiers = documentSnapshot.data().map().toList();
//       return filiers;
//     } catch (e) {
//       debugPrint('Error getting filiers: $e');
//     }
//   }

//   Future<List<String>> getEmailsForFilier(String filier) async {
//     return [];
//   }

//   Future<void> addFilier(Part filiere) async {
//     try {
//       await _firebaseFirestore.collection('filiers').doc(filiere.code).set({
//         'filiere': filiere.filiere,
//         'code': filiere.code,
//         'nbYears': filiere.nbYears,
//       });
//     } catch (e) {
//       debugPrint('Error adding filier: $e');
//     }
//   }

//   Future<void> addEmailsToFiliere(
//     UserEmailEntity newEmail,
//     Part part,
//   ) async {
//     try {
//       await _firebaseFirestore.collection('emails').doc(newEmail.id).set(
//         {
//           'id': newEmail.id,
//           'email': newEmail.email,
//           'role': newEmail.role.index,
//         },
//       );
//       await _firebaseFirestore
//           .collection('filiers') // Filieres collection
//           .doc(part.code)
//           .collection(
//               part.niveaux.toString()) // Years of one filiere collection
//           .doc('${part.code}${part.nbYears}')
//           .collection(part.part.toString()) // Part 1 and 2 collections
//           .doc(part.part.toString()) //
//           .set({
//         'filiere': part.filiere,
//         'code': part.code,
//         'niveaux': part.niveaux,
//       });
//       await _firebaseFirestore
//           .collection('${newEmail.role.name}s_emails')
//           .doc(newEmail.id)
//           .set(
//         {
//           'id': newEmail.id,
//           'email': newEmail.email,
//           'role': newEmail.role.index,
//         },
//       );
//     } catch (e) {
//       debugPrint("Error adding email to Firestore: $e");
//     }
//   }
// }
