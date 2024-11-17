import '../../../../../core/utils/enums.dart';

class UserProfileEntity {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime birthDay;
  final String phoneNumber;
  final UserRole role;
  final UserGender sexe;
  final String? imageUrl;

  UserProfileEntity({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.birthDay,
    required this.phoneNumber,
    required this.role,
    required this.sexe,
    required this.imageUrl,
  });
}
