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
      id: doc['id'],
      email: doc['email'],
      role: getRoleFromInt(doc['role']),
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role.index,
    };
  }
}

UserRole getRoleFromInt(int roleInt) {
  switch (roleInt) {
    case 1:
      return UserRole.professor;
    case 2:
      return UserRole.student;

    default:
      throw ArgumentError('Invalid role value: $roleInt');
  }
}
