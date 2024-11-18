import 'package:bloc/bloc.dart';
import 'package:studify/src/common/auth/domain/entities/user_login_entity.dart';

import '../../../data/repositories/auth_repository.dart';
import '../auth/auth_bloc.dart';
import '../auth/auth_events.dart';
import 'register_events.dart';
import 'register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthBloc authBloc = AuthBloc();
  final AuthRepository _authRepository = AuthRepository();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterRequested>((event, emit) async {
      emit(RegisterInProgress());
      try {
        // Simulate a network request for registration
        await _authRepository.register(event.user);
        // On success, update the AuthBloc to reflect authentication
        // authBloc.add(AuthLoggedIn(UserLoginEntity(
        //   email: event.user.email,
        //   password: event.user.password,
        // )));
        emit(RegisterSuccess());
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
