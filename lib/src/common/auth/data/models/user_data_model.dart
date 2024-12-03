import 'package:studify/core/utils/enums.dart';

import '../../../../../core/utils/helpers.dart';

class UserDataModel {
  final String id;
  final String email;
  final UserRole role;
  final String firstName;
  final String lastName;
  final String? imageUrl;

  UserDataModel({
    required this.id,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
  });

  // Factory constructor to create a UserModel from a Firestore document
  factory UserDataModel.fromDocument(Map<String, dynamic> doc) {
    return UserDataModel(
      id: doc['uid'] as String,
      email: doc['email'] as String,
      role: convertToEnumRole(doc['role'] as int),
      firstName: doc['firstName'] as String,
      lastName: doc['lastName'] as String,
      imageUrl: doc['imageUrl'] as String?,
    );
  }

  // Factory constructor to create a UserModel from a JSON object
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['uid'] as String,
      email: json['email'] as String,
      role: convertToEnumRole(json['role'] as int),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  // Method to convert the UserModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
    };
  }

  // Method to convert the UserModel to a Firestore document
  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
    };
  }

  // CopyWith method for immutability
  UserDataModel copyWith({
    String? id,
    String? email,
    UserRole? role,
    String? firstName,
    String? lastName,
    String? imageUrl,
  }) {
    return UserDataModel(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
