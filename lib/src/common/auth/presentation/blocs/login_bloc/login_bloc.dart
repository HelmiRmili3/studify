// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../../../data/repositories/auth_repository.dart';
// import 'login_events.dart';
// import 'login_states.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository authRepository;

//   AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
//     on<AuthSignInEvent>(_onSignIn);
//     on<AuthSignOutEvent>(_onSignOut);
//     on<AuthSignUpEvent>(_onSignUp);
//   }

//   Future<void> _onSignIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoadingState());
//     try {
//       UserCredential? user = await authRepository.login(
//         event.user,
//       );
//       emit(AuthSignedInState(user: user));
//     } catch (e) {
//       emit(AuthErrorState(error: e.toString()));
//     }
//   }

//   Future<void> _onSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoadingState());
//     try {
//       UserCredential? user = await authRepository.register(event.user);
//       emit(AuthSignedInState(user: user));
//     } catch (e) {
//       emit(AuthErrorState(error: e.toString()));
//     }
//   }

//   Future<void> _onSignOut(
//       AuthSignOutEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoadingState());
//     try {
//       // await authRepository.signOut();
//       emit(AuthSignedOutState());
//     } catch (e) {
//       emit(AuthErrorState(error: e.toString()));
//     }
//   }
// }
