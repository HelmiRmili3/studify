// Auth States

import '../../../data/models/user_profile_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  UserProfileModel? user;
  String succes;
  Authenticated(
    this.succes,
    this.user,
  );
}

class Unauthenticated extends AuthState {}

class AuthenticationFailure extends AuthState {
  final String error;
  AuthenticationFailure(this.error);
}

class RegisterSuccess extends AuthState {
  RegisterSuccess();
}

class RegisterFailure extends AuthState {
  final String error;
  RegisterFailure(this.error);
}
