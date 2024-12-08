import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/common/widgets/fading_circle_loading_indicator.dart';
import '../../../../../core/routes/route_names.dart';

import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../../../auth/presentation/blocs/auth/auth_states.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startSplashTimer();
  }

  void _startSplashTimer() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        GoRouter.of(context)
            .go(RoutesNames.authenticationHandler, extra: isFirstTime);
        prefs.setBool('isFirstTime', false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image.asset(
          "assets/images/all_logo.png",
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}

class AuthenticationHandler extends StatefulWidget {
  final bool isFirstTime;
  const AuthenticationHandler({
    super.key,
    required this.isFirstTime,
  });
  @override
  State<AuthenticationHandler> createState() => _AuthenticationHandlerState();
}

class _AuthenticationHandlerState extends State<AuthenticationHandler> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          GoRouter.of(context).go(RoutesNames.app, extra: state.user!.role);
        } else if (state is Unauthenticated) {
          if (widget.isFirstTime) {
            GoRouter.of(context).go(RoutesNames.onboarding);
          } else {
            GoRouter.of(context).go(RoutesNames.signin);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: const Center(
          child: FadingCircleLoadingIndicator(),
        ),
      ),
    );
  }
}
