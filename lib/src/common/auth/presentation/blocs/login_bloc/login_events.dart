import 'package:studify/src/common/auth/domain/entities/user_login_entity.dart';

import '../../../data/models/user_register_model.dart';

abstract class UserEvent {}

class UserInitial extends UserEvent {}

class UserLoggedIn extends UserEvent {
  final String username;
  final String password;
  UserLoggedIn({required this.username, required this.password});
}

class UserLoggedOut extends UserEvent {}

abstract class AuthEvent {}

class AuthSignInEvent extends AuthEvent {
  final UserLoginEntity user;

  AuthSignInEvent({required this.user});
}

class AuthSignOutEvent extends AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  final UserRegisterModel user;

  AuthSignUpEvent({required this.user});
}
