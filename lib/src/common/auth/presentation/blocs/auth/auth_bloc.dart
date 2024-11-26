import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/models/user_profile_model.dart';
import '../../../data/repositories/auth_repository.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthLoggedOut>(_onAuthLoggedOut);
  }

  Future<void> _onAuthStarted(
      AuthStarted event, Emitter<AuthState> emit) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      UserProfileModel? userProfile = await authRepository.getUser(user.uid);
      debugPrint("User Profile: ${userProfile!.toJson()}");
      emit(Authenticated("User logged in", userProfile));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onAuthLoggedIn(
      AuthLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential? userCredential = await authRepository.login(event.user);
      debugPrint("User Credential: $userCredential");
      if (userCredential != null) {
        UserProfileModel? userProfile =
            await authRepository.getUser(userCredential.user!.uid);
        debugPrint("User Profile: ${userProfile!.toJson()}");
        emit(Authenticated("User logged in", userProfile));
      }
    } catch (e) {
      debugPrint("Error login user in AuthloggedIn event $e");
      emit(Unauthenticated());
    }
  }

  Future<void> _onAuthLoggedOut(
      AuthLoggedOut event, Emitter<AuthState> emit) async {
    try {
      await authRepository.logout();
      emit(Unauthenticated());
    } catch (e) {
      debugPrint("Error logout user in AuthloggedOut event $e");
    }
  }
}
