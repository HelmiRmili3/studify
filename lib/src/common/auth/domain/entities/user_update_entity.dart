class UserUpdateEntity {
  final String firstName;
  final String lastName;
  final String password;
  final DateTime updatedAt;
  final String phoneNumber;
  final String imageUrl;

  UserUpdateEntity({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.updatedAt,
    required this.phoneNumber,
    required this.imageUrl,
  });
}
