import '../../../../../common/auth/data/models/user_email_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserEmailModel> users;
  UserLoaded(this.users);
}

class UserOperationSuccess extends UserState {
  final String message;
  UserOperationSuccess(this.message);
}

class UserError extends UserState {
  final String error;
  UserError(this.error);
}
