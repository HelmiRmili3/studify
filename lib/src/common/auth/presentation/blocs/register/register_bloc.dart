import 'package:bloc/bloc.dart';

import '../../../data/repositories/auth_repository.dart';

import 'register_events.dart';
import 'register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthRepository repository = AuthRepository();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onRegisterRequested(
      RegisterRequested event, Emitter<RegisterState> emit) async {
    emit(RegisterInProgress());
    try {
      // Perform registration
      await repository.register(event.user);

      // Authenticate the user upon successful registration
      // authBloc.add(AuthLoggedIn(UserLoginEntity(
      //   email: event.user.email,
      //   password: event.user.password,
      // )));

      // UserProfileModel? userProfile =
      //     await authRepository.getUser(userCredential!.user!.uid);
      // debugPrint("User Profile: ${userProfile!.toJson()}");
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(" Please try again."));
    }
  }
}
