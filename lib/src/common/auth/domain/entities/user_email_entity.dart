import '../../../../../core/utils/enums.dart';

class UserEmailEntity {
  final String id;
  final String email;
  final UserRole role;
  UserEmailEntity({
    required this.id,
    required this.email,
    required this.role,
  });
}
