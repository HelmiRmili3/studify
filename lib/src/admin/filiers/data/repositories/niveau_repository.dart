import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/enums.dart';
import '../../../../../core/utils/firestore.dart';
import '../../../../common/auth/data/models/user_email_model.dart';

class NiveauRepository {
  Stream<List<UserEmailModel>> streamNiveau(String code) async* {
    try {
      // Fetch the niveaux document to get the list of student IDs
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection(Firestore.years)
              .doc('2024')
              .collection(Firestore.niveaux)
              .doc(code)
              .get();

      // Check if the document exists and has data
      if (docSnapshot.exists && docSnapshot.data() != null) {
        // Extract the list of student IDs
        List<dynamic> studentIds =
            docSnapshot.data()!['emails'] as List<dynamic>;

        // List to hold futures of email models
        List<Future<UserEmailModel?>> emailFutures = studentIds.map((id) async {
          DocumentSnapshot<Map<String, dynamic>> emailSnapshot =
              await FirebaseFirestore.instance
                  .collection(Firestore.emails)
                  .doc(id)
                  .get();
          if (emailSnapshot.exists && emailSnapshot.data() != null) {
            // Parse the role correctly when creating the UserEmailModel
            return UserEmailModel.fromDocument(emailSnapshot.data()!);
          } else {
            return null; // Handle documents that might not exist
          }
        }).toList();

        // Resolve futures and filter out null values
        List<UserEmailModel?> emailModels = await Future.wait(emailFutures);
        List<UserEmailModel> validEmailModels =
            emailModels.whereType<UserEmailModel>().toList();

        yield validEmailModels;
      } else {
        yield [];
      }
    } catch (e) {
      debugPrint("Error fetching emails as stream: $e");
      yield [];
    }
  }

  Future<void> addEmail(UserEmailModel email, String niveauCode) async {
    try {
      // Query the "emails" collection to check if an email with the same address already exists
      var emailQuerySnapshot = await FirebaseFirestore.instance
          .collection(Firestore.emails)
          .where('email', isEqualTo: email.email)
          .get();

      if (emailQuerySnapshot.docs.isNotEmpty) {
        // If the email already exists, retrieve the id of the email document
        String existingEmailId = emailQuerySnapshot.docs.first.id;
        int existingEmailRole = emailQuerySnapshot.docs.first.data()['role'];
        debugPrint("Email already exists with ID: $existingEmailId");
        UserRole role = getRoleFromInt(existingEmailRole);
        if (email.role == role) {
          List<String> filieres = await getFilieresByUserId(existingEmailId);

          if (role == UserRole.student) {
            if (filieres.isEmpty) {
              await addFiliereToUser(existingEmailId, niveauCode);
            } else {
              debugPrint("Student already has a filiere");
              return;
            }
          } else {
            await addFiliereToUser(existingEmailId, niveauCode);
          }

          // Reference to the "niveaux" document with explicit type
          DocumentReference<Map<String, dynamic>> niveauRef = FirebaseFirestore
              .instance
              .collection(Firestore.years)
              .doc('2024')
              .collection(Firestore.niveaux)
              .doc(niveauCode)
              .withConverter<Map<String, dynamic>>(
                fromFirestore: (snapshot, _) => snapshot.data()!,
                toFirestore: (data, _) => data,
              );

          // Use a transaction to ensure atomicity
          await FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentSnapshot<Map<String, dynamic>> snapshot =
                await transaction.get(niveauRef);

            if (!snapshot.exists) {
              throw Exception("Niveau does not exist!");
            }

            // Safely cast snapshot data to a Map
            Map<String, dynamic> data = snapshot.data() ?? {};
            List<dynamic> emails = data["emails"] ?? [];

            if (!emails.contains(existingEmailId)) {
              // Add the new email ID to the emails list
              emails.add(existingEmailId);

              // Update the "emails" field in the document
              transaction.update(niveauRef, {"emails": emails});
              debugPrint("Email added successfully!");
            } else {
              debugPrint("Email ID is already in the list, skipping addition.");
            }
          });
        }
      } else {
        // If the email does not exist, add it to the "emails" collection
        await FirebaseFirestore.instance
            .collection(Firestore.emails)
            .doc(email.id) // Using the generated email ID as the document ID
            .set(email.toJson());

        // Reference to the "niveaux" document with explicit type
        DocumentReference<Map<String, dynamic>> niveauRef = FirebaseFirestore
            .instance
            .collection(Firestore.years)
            .doc('2024')
            .collection(Firestore.niveaux)
            .doc(niveauCode)
            .withConverter<Map<String, dynamic>>(
              fromFirestore: (snapshot, _) => snapshot.data()!,
              toFirestore: (data, _) => data,
            );

        // Use a transaction to ensure atomicity
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentSnapshot<Map<String, dynamic>> snapshot =
              await transaction.get(niveauRef);

          if (!snapshot.exists) {
            throw Exception("Niveau does not exist!");
          }

          // Safely cast snapshot data to a Map
          Map<String, dynamic> data = snapshot.data() ?? {};
          List<dynamic> emails = data["emails"] ?? [];

          if (!emails.contains(email.id)) {
            // Add the new email ID to the emails list
            emails.add(email.id);

            // Update the "emails" field in the document
            transaction.update(niveauRef, {"emails": emails});
            List<String> filieres = await getFilieresByUserId(email.id);
            if (email.role == UserRole.student) {
              if (filieres.isEmpty) {
                await addFiliereToUser(email.id, niveauCode);
              } else {
                debugPrint("Student already has a filiere");
                return;
              }
            } else {
              await addFiliereToUser(email.id, niveauCode);
            }
            debugPrint("Email added successfully!");
          } else {
            debugPrint("Email ID is already in the list, skipping addition.");
          }
        });
      }
    } catch (e) {
      debugPrint("Error adding email: $e");
    }
  }

  Future<void> addFiliereToUser(String userId, String newFiliere) async {
    try {
      // Reference to the "access" document for the given user ID
      DocumentReference<Map<String, dynamic>> accessRef = FirebaseFirestore
          .instance
          .collection(Firestore.years)
          .doc('2024')
          .collection(Firestore.access)
          .doc(userId)
          .withConverter<Map<String, dynamic>>(
            fromFirestore: (snapshot, _) => snapshot.data()!,
            toFirestore: (data, _) => data,
          );

      // Use a transaction to ensure atomicity
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await transaction.get(accessRef);

        if (!snapshot.exists) {
          // If the document doesn't exist, create a new one with the new filiere
          transaction.set(accessRef, {
            "filieres": [newFiliere]
          });
          debugPrint("Filiere added successfully!");
        } else {
          // If the document exists, update the filieres list
          Map<String, dynamic> data = snapshot.data() ?? {};
          List<dynamic> filieres = data["filieres"] ?? [];

          // Add the new filiere if it doesn't already exist in the list
          if (!filieres.contains(newFiliere)) {
            filieres.add(newFiliere);
            transaction.update(accessRef, {"filieres": filieres});
            debugPrint("Filiere added successfully!");
          } else {
            debugPrint(
                "Filiere already exists in the list, skipping addition.");
          }
        }
      });
    } catch (e) {
      debugPrint("Error adding filiere: $e");
    }
  }

  Future<List<String>> getFilieresByUserId(String userId) async {
    try {
      // Reference to the "access" document for the given user ID
      DocumentReference<Map<String, dynamic>> accessRef = FirebaseFirestore
          .instance
          .collection(Firestore.years)
          .doc('2024')
          .collection(Firestore.access)
          .doc(userId)
          .withConverter<Map<String, dynamic>>(
            fromFirestore: (snapshot, _) => snapshot.data()!,
            toFirestore: (data, _) => data,
          );

      // Fetch the access document
      DocumentSnapshot<Map<String, dynamic>> accessSnapshot =
          await accessRef.get();

      if (accessSnapshot.exists) {
        // Safely cast snapshot data to a Map
        Map<String, dynamic> data = accessSnapshot.data() ?? {};
        List<dynamic> filieres = data["filieres"] ?? [];

        // Convert to List<String> and return
        return filieres.map((filiere) => filiere as String).toList();
      } else {
        debugPrint("Access document does not exist for the user.");
        return [];
      }
    } catch (e) {
      debugPrint("Error fetching filieres: $e");
      return [];
    }
  }
}
