import 'package:studify/models/matiere.dart';

class MatiersState {}

class MatieresInitial extends MatiersState {}

class MatieresLoading extends MatiersState {}

class MatieresLoaded extends MatiersState {
  final List<Matiere> matiers;
  MatieresLoaded(this.matiers);
}

class MatieresError extends MatiersState {
  final String error;
  MatieresError(this.error);
}

class MatiereAdded extends MatiersState {}
