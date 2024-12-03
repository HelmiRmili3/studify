import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/users_repository.dart';
import 'users_events.dart';
import 'users_states.dart';

class UsersBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository repository = UsersRepository();

  UsersBloc() : super(UserInitial()) {
    // Fetch Users
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        await emit.forEach(
          repository.fetchUsers(), // Stream of users
          onData: (users) => UserLoaded(users),
          onError: (error, stackTrace) => UserError(error.toString()),
        );
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    // Add User
    on<AddUser>((event, emit) async {
      emit(UserLoading());
      try {
        // Add the user
        await repository.addUser(event.user);

        await emit.forEach(
          repository.fetchUsers(), // Stream of users
          onData: (users) => UserLoaded(users),
          onError: (error, stackTrace) => UserError(error.toString()),
        );
        emit(UserOperationSuccess("User added successfully"));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    // Update User
    on<UpdateUser>((event, emit) async {
      emit(UserLoading());
      try {
        await repository.updateUser(event.user.id, event.user);
        emit(UserOperationSuccess("User updated successfully"));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    // Delete User
    on<DeleteUser>((event, emit) async {
      emit(UserLoading());
      try {
        await repository.deleteUser(event.id);
        await emit.forEach(
          repository.fetchUsers(), // Stream of users
          onData: (users) => UserLoaded(users),
          onError: (error, stackTrace) => UserError(error.toString()),
        );
        emit(UserOperationSuccess("User deleted successfully"));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
