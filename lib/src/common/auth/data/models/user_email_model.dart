import '../../../../../core/utils/enums.dart'; // Import your UserRole enum
import '../../domain/entities/user_email_entity.dart';

class UserEmailModel extends UserEmailEntity {
  UserEmailModel({
    required super.id,
    required super.email,
    required super.role,
  });
  factory UserEmailModel.fromDocument(Map<String, dynamic> doc) {
    return UserEmailModel(
      id: doc['id'] ?? '',
      email: doc['email'] ?? '',
      role: UserRole.admin,
    );
  }

  UserEmailModel copyWith({
    String? id,
    String? email,
    UserRole? role,
  }) {
    return UserEmailModel(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }
}
