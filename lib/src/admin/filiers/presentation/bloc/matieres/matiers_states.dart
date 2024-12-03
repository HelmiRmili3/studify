import 'package:studify/models/matiere.dart';
import 'package:studify/models/user.dart';

class MatiersState {}

class MatieresInitial extends MatiersState {}

class MatieresLoading extends MatiersState {}

class MatieresLoaded extends MatiersState {
  final List<Matiere> matiers;
  MatieresLoaded(
    this.matiers,
  );
}

class MatieresError extends MatiersState {
  final String error;
  MatieresError(this.error);
}

class MatiereAdded extends MatiersState {}

class MatiereUpdated extends MatiersState {
  final Matiere matiere;
  final UserModel professor;
  MatiereUpdated(
    this.matiere,
    this.professor,
  );
}
