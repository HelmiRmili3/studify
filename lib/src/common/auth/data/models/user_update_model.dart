import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studify/core/utils/enums.dart';

import '../../../../../core/utils/helpers.dart';

class UserUpdateModel {
  final String firstName;
  final String lastName;
  final DateTime updatedAt;
  final DateTime birthDay;
  final String phoneNumber;
  final UserGender sexe;
  final String imageUrl;

  UserUpdateModel({
    required this.firstName,
    required this.lastName,
    required this.updatedAt,
    required this.phoneNumber,
    required this.birthDay,
    required this.sexe,
    required this.imageUrl,
  });

  // Factory constructor to create a model from JSON
  factory UserUpdateModel.fromJson(Map<String, dynamic> json) {
    return UserUpdateModel(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      birthDay: DateTime.parse(json['birthDay'] as String),
      phoneNumber: json['phoneNumber'] as String,
      sexe: convertToEnumGender(json['sexe']),
      imageUrl: json['imageUrl'] as String,
    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'birthDay': Timestamp.fromDate(birthDay),
      'phoneNumber': phoneNumber,
      'sexe': sexe.index,
      'imageUrl': imageUrl,
    };
  }

  // CopyWith method for immutability and updates
  UserUpdateModel copyWith({
    String? firstName,
    String? lastName,
    DateTime? updatedAt,
    DateTime? birthDay,
    String? phoneNumber,
    UserGender? sexe,
    String? imageUrl,
  }) {
    return UserUpdateModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      updatedAt: updatedAt ?? this.updatedAt,
      birthDay: birthDay ?? this.birthDay,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      sexe: sexe ?? this.sexe,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
