import 'package:studify/models/matiere.dart';

/// Filiere States
abstract class MatiereStates {}

class MatiereInitial extends MatiereStates {}

class MatiereLoading extends MatiereStates {}

class MatiereLoaded extends MatiereStates {
  final List<Doc> docs;
  MatiereLoaded(this.docs);
}

class MatiereError extends MatiereStates {
  final String message;
  MatiereError(this.message);
}

class DocAdding extends MatiereStates {}

class DocAdded extends MatiereStates {}

class DocError extends MatiereStates {
  final String message;
  DocError(this.message);
}

/// Niveau States

