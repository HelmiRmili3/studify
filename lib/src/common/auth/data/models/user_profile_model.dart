import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/utils/enums.dart';
import '../../domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    required super.uid,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.createdAt,
    required super.updatedAt,
    required super.birthDay,
    required super.phoneNumber,
    required super.sexe,
    super.imageUrl,
    required super.role,
  });

  // Convert JSON to UserProfileModel
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      createdAt: _convertTimestamp(json['createdAt']),
      updatedAt: _convertTimestamp(json['updatedAt']),
      birthDay: _convertTimestamp(json['birthDay']),
      phoneNumber: json['phoneNumber'] as String,
      sexe: _convertToEnumGender(json['sexe']),
      imageUrl: json['imageUrl'] as String,
      role: _convertToEnumRole(json['role']),
    );
  }

  static UserGender _convertToEnumGender(int? genderIndex) {
    switch (genderIndex) {
      case 0:
        return UserGender.male;
      case 1:
        return UserGender.female;
      default:
        return UserGender.unknown;
    }
  }

  static UserRole _convertToEnumRole(int? roleIndex) {
    switch (roleIndex) {
      case 0:
        return UserRole.admin;
      case 1:
        return UserRole.professor;
      case 2:
        return UserRole.student;
      default:
        return UserRole.unknown;
    }
  }

  // Convert UserProfileModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'birthDay': birthDay.toIso8601String(),
      'phoneNumber': phoneNumber,
      'sexe': sexe.name,
      'imageUrl': imageUrl,
      'role': role.name,
    };
  }

  // Create a copy with updated values
  UserProfileModel copyWith({
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
    return UserProfileModel(
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

  static DateTime _convertTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate(); // Convert Timestamp to DateTime
    } else {
      return DateTime
          .now(); // Default to current time if it's null or unexpected type
    }
  }
}
