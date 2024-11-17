// Register Events
import 'package:studify/src/common/auth/data/models/user_register_model.dart';

abstract class RegisterEvent {}

class RegisterRequested extends RegisterEvent {
  final UserRegisterModel user;
  RegisterRequested(this.user);
}

class RegisterSuccessEvent extends RegisterEvent {}

class RegisterFailureEvent extends RegisterEvent {
  final String error;
  RegisterFailureEvent(this.error);
}
