import 'package:studify/core/utils/enums.dart';

UserRole convertToEnumRole(int? index) {
  switch (index) {
    case 0:
      return UserRole.admin;
    case 1:
      return UserRole.professor;
    case 2:
      return UserRole.student;
    default:
      return UserRole.unknown;
  }
}

UserGender convertToEnumGender(int? index) {
  switch (index) {
    case 0:
      return UserGender.male;
    case 1:
      return UserGender.female;
    default:
      return UserGender.unknown;
  }
}

MatiereType convertToEnumType(int? index) {
  switch (index) {
    case 0:
      return MatiereType.co;
    case 1:
      return MatiereType.td;
    case 2:
      return MatiereType.td;
    default:
      return MatiereType.co;
  }
}

MatierePart convertToEnumPart(int? index) {
  switch (index) {
    case 0:
      return MatierePart.p1;
    case 1:
      return MatierePart.p2;
    default:
      return MatierePart.p1;
  }
}

extension StringExtensions on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
