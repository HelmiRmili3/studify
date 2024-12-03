import '../../../../../common/auth/data/models/user_data_model.dart';

abstract class NiveauState {}

class NiveauInitial extends NiveauState {}

class NiveauLoading extends NiveauState {}

class EmailAdded extends NiveauState {}

class NiveauLoaded extends NiveauState {
  final List<UserDataModel> niveau;
  NiveauLoaded(this.niveau);
}

class NiveauError extends NiveauState {
  final String error;
  NiveauError(this.error);
}
