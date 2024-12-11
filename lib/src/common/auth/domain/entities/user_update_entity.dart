import 'package:studify/core/utils/enums.dart';

class UserUpdateEntity {
  final String firstName;
  final String lastName;
  final DateTime updatedAt;
  final DateTime birthDay;
  final String phoneNumber;
  final UserGender sexe;
  final String imageUrl;

  UserUpdateEntity({
    required this.firstName,
    required this.lastName,
    required this.updatedAt,
    required this.phoneNumber,
    required this.birthDay,
    required this.sexe,
    required this.imageUrl,
  });
}
