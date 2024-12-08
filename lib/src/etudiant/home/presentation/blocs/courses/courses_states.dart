import 'package:studify/models/matiere.dart';

/// Filiere States
abstract class CoursesStates {}

// matieres states
class MatieresInitial extends CoursesStates {}

class MatieresLoading extends CoursesStates {}

class MatieresLoaded extends CoursesStates {
  final List<Matiere> matieres;
  MatieresLoaded(this.matieres);
}

class MatieresError extends CoursesStates {
  final String message;
  MatieresError(this.message);
}
