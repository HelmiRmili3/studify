import 'package:firebase_auth/firebase_auth.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserAuthenticated extends UserState {
  final User user;

  UserAuthenticated({required this.user});
}

class UserUnauthenticated extends UserState {}

class UserFailure extends UserState {
  final String errorMessage;

  UserFailure({required this.errorMessage});
}
