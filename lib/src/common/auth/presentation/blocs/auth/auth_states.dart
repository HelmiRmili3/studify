// Auth States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final String user;
  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}

class AuthenticationFailure extends AuthState {
  final String error;
  AuthenticationFailure(this.error);
}
