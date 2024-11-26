import 'package:studify/src/common/auth/data/models/user_email_model.dart';

abstract class NiveauState {}

class NiveauInitial extends NiveauState {}

class NiveauLoading extends NiveauState {}

class EmailAdded extends NiveauState {}

class NiveauLoaded extends NiveauState {
  final List<UserEmailModel> niveau;
  NiveauLoaded(this.niveau);
}

class NiveauError extends NiveauState {
  final String error;
  NiveauError(this.error);
}
