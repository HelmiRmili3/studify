import '../../../../../../models/filiere.dart';

/// Filiere States
abstract class ProfessorFilieresStates {}

// filiere states
class FilieresInitial extends ProfessorFilieresStates {}

class FilieresLoading extends ProfessorFilieresStates {}

class FilieresLoaded extends ProfessorFilieresStates {
  final List<Filiere> filieres;
  FilieresLoaded(this.filieres);
}

class FilieresError extends ProfessorFilieresStates {
  final String message;
  FilieresError(this.message);
}
