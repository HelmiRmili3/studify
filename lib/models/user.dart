import 'package:studify/core/utils/enums.dart';

class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime birthDay;
  final String phoneNumber;
  final UserGender sexe;
  final String imageUrl;

  User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.birthDay,
    required this.phoneNumber,
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'birthDay': birthDay.toIso8601String(),
      'phoneNumber': phoneNumber,
      'sexe': sexe,
      'imageUrl': imageUrl,
    };
  }

  // Factory to create User from Firebase data
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      birthDay: DateTime.parse(map['birthDay']),
      phoneNumber: map['phoneNumber'],
      sexe: map['sexe'],
      imageUrl: map['imageUrl'],
    );
  }
}
