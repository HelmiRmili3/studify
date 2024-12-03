import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studify/core/utils/firestore.dart';
import 'package:studify/src/common/auth/data/models/user_email_model.dart';

class UsersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<UserEmailModel>> fetchUsers() {
    try {
      return _firestore
          .collection(Firestore.emails)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return UserEmailModel.fromDocument(doc.data());
        }).toList();
      });
    } catch (e) {
      throw Exception("Failed to fetch users: $e");
    }
  }

  Future<UserEmailModel?> addUser(UserEmailModel user) async {
    try {
      DocumentReference docRef =
          _firestore.collection(Firestore.emails).doc(user.id);
      await docRef.set(user.toJson());
      DocumentSnapshot docSnapshot = await docRef.get();
      return UserEmailModel.fromDocument(
          docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Failed to add user: $e");
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _firestore.collection(Firestore.emails).doc(id).delete();
    } catch (e) {
      throw Exception("Failed to delete user: $e");
    }
  }

  Future<UserEmailModel?> updateUser(String id, UserEmailModel user) async {
    try {
      // await _firestore.collection(collectionPath).doc(id).update(user.toJson());
      // DocumentSnapshot docSnapshot =
      //     await _firestore.collection(collectionPath).doc(id).get();
      // return User.fromJson(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Failed to update user: $e");
    }
  }
}
