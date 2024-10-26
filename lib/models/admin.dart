import 'user.dart';

class Admin extends User {
  final bool isSuperAdmin;

  Admin({
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
    required this.isSuperAdmin,
  });

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'isSuperAdmin': isSuperAdmin,
    });
    return map;
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
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
      isSuperAdmin: map['isSuperAdmin'] ?? false,
    );
  }
}
