import '../../../../../../models/filiere.dart';

/// Filiere States
abstract class MatiereStates {}

class MatiereInitial extends MatiereStates {}

class MatiereLoading extends MatiereStates {}

class MatiereLoaded extends MatiereStates {
  final List<Filiere> filieres;
  MatiereLoaded(this.filieres);
}

class MatiereError extends MatiereStates {
  final String message;
  MatiereError(this.message);
}

class MatiereAdding extends MatiereStates {}

class MatiereAdded extends MatiereStates {}

/// Niveau States

