// Auth Events
import '../../../data/models/user_register_model.dart';
import '../../../domain/entities/user_login_entity.dart';

abstract class AuthEvent {}

class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final UserLoginEntity user;
  AuthLoggedIn(this.user);
}

class AuthLoggedOut extends AuthEvent {}

class RegisterRequested extends AuthEvent {
  final UserRegisterModel user;
  RegisterRequested(this.user);
}

class RegisterSuccessEvent extends AuthEvent {}

class RegisterFailureEvent extends AuthEvent {
  final String error;
  RegisterFailureEvent(this.error);
}
