import 'user.dart';

class Professor extends User {
  final String department; // E.g., Mathematics
  final List<String> uploadedCourses; // List of course IDs

  Professor({
    required super.uid,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.createdAt,
    required super.updatedAt,
    required super.birthDay,
    required super.phoneNumber,
    required super.sexe,
    required super.imageUrl,
    required this.department,
    required this.uploadedCourses,
  });

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'department': department,
      'uploadedCourses': uploadedCourses,
    });
    return map;
  }

  factory Professor.fromMap(Map<String, dynamic> map) {
    return Professor(
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
      department: map['department'],
      uploadedCourses: List<String>.from(map['uploadedCourses']),
    );
  }

  // Convert Professor to JSON
  Map<String, dynamic> toJson() => toMap();

  // Convert JSON to Professor
  factory Professor.fromJson(Map<String, dynamic> json) =>
      Professor.fromMap(json);
}
