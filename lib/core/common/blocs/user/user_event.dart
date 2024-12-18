// user_event.dart

import '../../../../models/matiere.dart';
import '../../../../src/common/auth/data/models/user_update_model.dart';

abstract class UserEvent {}

class FetchUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final UserUpdateModel user;
  final FileEntity? newImage;
  UpdateUser({
    required this.user,
    required this.newImage,
  });
}

class DeleteUser extends UserEvent {}

class AddAdmin extends UserEvent {
  AddAdmin();
}
