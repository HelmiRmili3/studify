import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/models/user_profile_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/entities/user_login_entity.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<RegisterRequested>(_onRegisterRequested);
    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthLoggedOut>(_onAuthLoggedOut);
  }

  Future<void> _onAuthStarted(
      AuthStarted event, Emitter<AuthState> emit) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        UserProfileModel? userProfile = await authRepository.getUser(user.uid);
        debugPrint("User Profile: ${userProfile!.toJson()}");
        emit(Authenticated("User logged in", userProfile));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      debugPrint("Error in _onAuthStarted: $e");
      emit(AuthenticationFailure("Error checking authentication status : $e"));
    }
  }

  Future<void> _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.register(event.user).then((userCredential) async {
        return await authRepository.getUser(userCredential!.user!.uid);
      }).then((_) {
        UserLoginEntity user = UserLoginEntity(
          email: event.user.email,
          password: event.user.password,
        );
        add(AuthLoggedIn(user));
      });
    } catch (e) {
      debugPrint("Error in _onRegisterRequested: $e");
      emit(RegisterFailure("Error registering user"));
    }
  }

  Future<void> _onAuthLoggedIn(
      AuthLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    debugPrint("AuthLoggedIn: Attempting login...");
    try {
      UserCredential? userCredential = await authRepository.login(event.user);
      debugPrint("AuthLoggedIn: UserCredential = $userCredential");

      if (userCredential != null) {
        UserProfileModel? userProfile =
            await authRepository.getUser(userCredential.user!.uid);
        debugPrint("AuthLoggedIn: UserProfile = $userProfile");
        if (userProfile != null) {
          emit(Authenticated("User logged in", userProfile));
          return;
        }
        return;
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      debugPrint("AuthLoggedIn: Error = $e");
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onAuthLoggedOut(
      AuthLoggedOut event, Emitter<AuthState> emit) async {
    try {
      await authRepository.logout();
      emit(Unauthenticated());
    } catch (e) {
      debugPrint("Error logging out user in AuthLoggedOut event: $e");
      emit(AuthenticationFailure(e.toString()));
    }
  }
}
