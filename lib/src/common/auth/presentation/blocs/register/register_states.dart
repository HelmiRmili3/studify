// register_bloc.dart

// Register States

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterInProgress extends RegisterState {}

class RegisterSuccess extends RegisterState {
  RegisterSuccess();
}

class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}
