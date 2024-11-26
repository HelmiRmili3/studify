import '../../../../../../models/filiere.dart';

/// Filiere States
abstract class FiliereState {}

class FiliereInitial extends FiliereState {}

class FiliereLoading extends FiliereState {}

class FiliereLoaded extends FiliereState {
  final List<Filiere> filieres;
  FiliereLoaded(this.filieres);
}

class FiliereError extends FiliereState {
  final String message;
  FiliereError(this.message);
}

class FiliereOperationSuccess extends FiliereState {}

class FiliereAdding extends FiliereState {}

class FiliereAdded extends FiliereState {}

/// Niveau States

