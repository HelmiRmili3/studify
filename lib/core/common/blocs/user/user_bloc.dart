import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studify/models/user.dart';
import '../../../service/secure_storage_service.dart';
import '../../repositorys/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository = UserRepository();
  final UserProfileStorage userProfileStorage = UserProfileStorage();

  late UserModel? user;

  UserBloc() : super(UserInitial()) {
    on<FetchUser>(_onFetchUser);
    on<UpdateUser>(_onUpdateUser);
    on<AddAdmin>(_onAddAdminUser);
  }

  Future<void> _onFetchUser(FetchUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      user = await _userRepository.getUser();

      if (user != null) {
        emit(UserLoaded(user!));
      } else {
        emit(UserError("Failed to load user."));
      }
    } catch (e) {
      emit(UserError("Error fetching user: $e"));
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      UserModel? updateduser = await _userRepository.updateUser(
        event.user,
        event.newImage,
      );
      emit(UserLoaded(updateduser!));
    } catch (e) {
      emit(UserError("Error updating user: $e"));
    }
  }

  Future<void> _onAddAdminUser(AddAdmin event, Emitter<UserState> emit) async {
    try {
      await _userRepository.addAdmin('admin.studify@isimg.tn');
    } catch (e) {
      debugPrint('Error Adding admin: $e');
    }
  }
}
