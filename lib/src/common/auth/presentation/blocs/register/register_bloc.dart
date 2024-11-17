import 'package:bloc/bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import '../auth/auth_bloc.dart';
import 'register_events.dart';
import 'register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthBloc authBloc;
  final AuthRepository _authRepository;

  RegisterBloc(this.authBloc, this._authRepository) : super(RegisterInitial()) {
    // Register the event handler
    on<RegisterRequested>((event, emit) async {
      emit(RegisterInProgress());
      try {
        // Simulate a network request for registration
        await _authRepository.register(event.user);

        // On success, update the AuthBloc to reflect authentication
        // authBloc.add(AuthLoggedIn("new_user"));
        emit(RegisterSuccess());
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
