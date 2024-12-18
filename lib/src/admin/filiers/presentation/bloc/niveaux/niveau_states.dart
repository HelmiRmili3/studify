import 'package:studify/models/matiere.dart';

import '../../../../../../models/user.dart';
import '../../../../../common/auth/data/models/user_data_model.dart';

abstract class NiveauState {}

class NiveauInitial extends NiveauState {}

class NiveauLoading extends NiveauState {}

class EmailAdded extends NiveauState {}

class MatiereAdded extends NiveauState {}

class MatiereUpdated extends NiveauState {
  final Matiere matiere;
  final UserModel professor;
  MatiereUpdated(
    this.matiere,
    this.professor,
  );
}

class NiveauLoaded extends NiveauState {
  final List<UserDataModel> students;
  final List<UserDataModel> professors;
  final List<Matiere> matieres;
  NiveauLoaded(
    this.students,
    this.professors,
    this.matieres,
  );
}

class NiveauError extends NiveauState {
  final String error;
  NiveauError(this.error);
}
