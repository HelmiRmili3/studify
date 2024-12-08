import 'user.dart';

class Student extends UserModel {
  final String major; // E.g., Computer Science
  final String majorId; // E.g., CS101
  final String studentId; // E.g., 123456789
  final String yearOfStudy; // E.g., Freshman
  final String groupe; // E.g., A

  Student({
    required super.uid,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.createdAt,
    required super.updatedAt,
    required super.birthDay,
    required super.phoneNumber,
    required super.sexe,
    required super.role,
    required super.imageUrl,
    required this.major,
    required this.majorId,
    required this.studentId,
    required this.yearOfStudy,
    required this.groupe,
  });

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'major': major,
      'majorId': majorId,
      'studentId': studentId,
      'yearOfStudy': yearOfStudy,
      'groupe': groupe,
    });
    return map;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      birthDay: DateTime.parse(map['birthDay']),
      phoneNumber: map['phoneNumber'],
      sexe: map['sexe'],
      role: map['role'],
      imageUrl: map['imageUrl'],
      major: map['major'],
      majorId: map['majorId'],
      studentId: map['studentId'],
      yearOfStudy: map['yearOfStudy'],
      groupe: map['groupe'],
    );
  }

  // Convert Student to JSON
  Map<String, dynamic> toJson() => toMap();

  // Convert JSON to Student
  factory Student.fromJson(Map<String, dynamic> json) => Student.fromMap(json);
}
