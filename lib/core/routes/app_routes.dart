import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/core/routes/route_names.dart';
import 'package:studify/src/auth/presentation/views/create_new_password_screen.dart';
import 'package:studify/src/auth/presentation/views/fill_your_profile_screen.dart';
import 'package:studify/src/auth/presentation/views/forget_password_screen.dart';
import 'package:studify/src/auth/presentation/views/signin_screen.dart';
import 'package:studify/src/home/presentation/views/home_screen.dart';

import '../../src/auth/presentation/views/signup_screen.dart';
import '../../src/on_boarding/presentation/views/on_boarding_screen.dart';

class AppRouter {
  static GoRouter router = _buildRouter();

  static GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: RoutesNames.onboarding,
      errorPageBuilder: (context, state) => MaterialPage(
        child: Scaffold(
          body: Center(
            child: Text(state.error.toString()),
          ),
        ),
      ),
      routes: [
        GoRoute(
          name: RoutesNames.onboarding,
          path: RoutesNames.onboarding,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const OnboardingScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: const OnboardingScreen(),
                );
              },
            );
          },
        ),
        GoRoute(
          path: RoutesNames.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RoutesNames.signin,
          builder: (context, state) => const SigninScreen(),
        ),
        GoRoute(
          path: RoutesNames.signup,
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: RoutesNames.fillYourProfile,
          builder: (context, state) => const FillYourProfileScreen(),
        ),
        GoRoute(
          path: RoutesNames.forgotPassword,
          builder: (context, state) => const ForgetPasswordScreen(),
        ),
        GoRoute(
          path: RoutesNames.resetPassword,
          builder: (context, state) => const CreateNewPasswordScreen(),
        ),
        // GoRoute(
        //   path: dashboard,
        //   builder: (context, state) => const DashboardPage(),
        // ),
        // GoRoute(
        //   path: profile,
        //   builder: (context, state) => const ProfilePage(),
        // ),
      ],
    );
  }
}
