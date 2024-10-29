import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:studify/core/routes/app_routes.dart';
import 'package:studify/core/common/blocs/theme/theme_bloc.dart';
import 'package:studify/core/common/blocs/theme/theme_state.dart';
import 'package:studify/core/services/shared_preferences_repo.dart';

import 'core/common/blocs/theme/theme_event.dart';
import 'src/common/on_boarding/presentation/blocs/onboarding/onboarding_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferencesRepo =
      SharedPreferencesRepository(userKey: 'user_data');

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        Provider<ThemeBloc>(create: (_) => ThemeBloc()..add(LoadThemeEvent())),
        Provider<OnboardingBloc>(create: (_) => OnboardingBloc(3)),

        // Add other providers if necessary
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'Studify',
              debugShowCheckedModeBanner: false,
              theme: state.themeData,
              routeInformationProvider:
                  AppRouter.router.routeInformationProvider,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routerDelegate: AppRouter.router.routerDelegate,
            );
          },
        );
      },
    );
  }
}
