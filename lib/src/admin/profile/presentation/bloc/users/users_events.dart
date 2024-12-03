import 'package:studify/src/common/auth/data/models/user_email_model.dart';

abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class AddUser extends UserEvent {
  final UserEmailModel user;
  AddUser(this.user);
}

class DeleteUser extends UserEvent {
  final String id;
  DeleteUser(this.id);
}

class UpdateUser extends UserEvent {
  final UserEmailModel user;
  UpdateUser(this.user);
}
