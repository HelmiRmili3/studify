// Auth Events
import '../../../domain/entities/user_login_entity.dart';

abstract class AuthEvent {}

class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final UserLoginEntity user;
  AuthLoggedIn(this.user);
}

class AuthLoggedOut extends AuthEvent {}
