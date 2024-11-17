import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLoggedIn) {
      yield Authenticated(event.user);
    } else if (event is AuthLoggedOut) {
      yield Unauthenticated();
    } else if (event is AuthStarted) {
      yield Unauthenticated(); // Start by assuming the user is unauthenticated
    }
  }
}
