import '../../../../../core/utils/enums.dart';
import '../../domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    required super.uid,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.password,
    required super.createdAt,
    required super.updatedAt,
    required super.birthDay,
    required super.phoneNumber,
    required super.sexe,
    super.imageUrl,
    required super.role,
  });

  // Convert JSON to UserProfileModel
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      birthDay: DateTime.parse(json['birthDay'] as String),
      phoneNumber: json['phoneNumber'] as String,
      sexe: UserGender.values.firstWhere(
        (gender) => gender.name == (json['sexe'] as String),
        orElse: () => UserGender.unknown,
      ),
      imageUrl: json['imageUrl'] as String,
      role: UserRole.values.firstWhere(
        (role) => role.name == (json['role'] as String),
        orElse: () => UserRole.unknown,
      ),
    );
  }

  // Convert UserProfileModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'birthDay': birthDay.toIso8601String(),
      'phoneNumber': phoneNumber,
      'sexe': sexe.name,
      'imageUrl': imageUrl,
      'role': role.name,
    };
  }

  // Create a copy with updated values
  UserProfileModel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? birthDay,
    String? phoneNumber,
    UserRole? role,
    UserGender? sexe,
    String? imageUrl,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      birthDay: birthDay ?? this.birthDay,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      sexe: sexe ?? this.sexe,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
