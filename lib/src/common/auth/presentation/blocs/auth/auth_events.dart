// Auth Events
abstract class AuthEvent {}

class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final String user;
  AuthLoggedIn(this.user);
}

class AuthLoggedOut extends AuthEvent {}
