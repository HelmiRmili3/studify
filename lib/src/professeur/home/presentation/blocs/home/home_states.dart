import 'package:studify/models/matiere.dart';

/// Filiere States
abstract class HomeStates {}

// matieres states
class MatieresInitial extends HomeStates {}

class MatieresLoading extends HomeStates {}

class MatieresLoaded extends HomeStates {
  final List<Matiere> matieres;
  MatieresLoaded(this.matieres);
}

class MatieresError extends HomeStates {
  final String message;
  MatieresError(this.message);
}
