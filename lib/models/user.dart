import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studify/core/utils/enums.dart';
import '../core/utils/helpers.dart';

class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime birthDay;
  final String phoneNumber;
  final UserRole role;
  final UserGender sexe;
  final String imageUrl;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.birthDay,
    required this.phoneNumber,
    required this.role,
    required this.sexe,
    required this.imageUrl,
  });

  // Convert to Map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'birthDay': Timestamp.fromDate(birthDay),
      'phoneNumber': phoneNumber,
      'role': role.index,
      'sexe': sexe.index,
      'imageUrl': imageUrl,
    };
  }

  // Factory to create User from Firebase data
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      birthDay: (map['birthDay'] as Timestamp).toDate(),
      phoneNumber: map['phoneNumber'],
      role: convertToEnumRole(map['role']),
      sexe: convertToEnumGender(map['sexe']),
      imageUrl: map['imageUrl'],
    );
  }

  // CopyWith method
  UserModel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? birthDay,
    String? phoneNumber,
    UserRole? role,
    UserGender? sexe,
    String? imageUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      birthDay: birthDay ?? this.birthDay,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      sexe: sexe ?? this.sexe,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
