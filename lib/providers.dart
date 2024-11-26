import 'package:provider/provider.dart';
import 'package:studify/core/common/blocs/theme/theme_bloc.dart';

import 'core/common/blocs/theme/theme_event.dart';
import 'src/admin/filiers/presentation/bloc/filieres/filiere_bloc.dart';
import 'src/admin/filiers/presentation/bloc/matieres/matiers_bloc.dart';
import 'src/admin/filiers/presentation/bloc/niveaux/niveau_bloc.dart';
import 'src/common/auth/presentation/blocs/auth/auth_bloc.dart';
import 'src/common/auth/presentation/blocs/auth/auth_events.dart';
import 'src/common/auth/presentation/blocs/register/register_bloc.dart';
import 'src/common/on_boarding/presentation/blocs/onboarding/onboarding_bloc.dart';

List<Provider> porviders = [
  Provider<ThemeBloc>(create: (_) => ThemeBloc()..add(LoadThemeEvent())),
  Provider<OnboardingBloc>(create: (_) => OnboardingBloc(3)),
  Provider<AuthBloc>(create: (_) => AuthBloc()..add(AuthStarted())),
  Provider<RegisterBloc>(create: (_) => RegisterBloc()),
  Provider<FiliereBloc>(create: (context) => FiliereBloc()),
  Provider<NiveauBloc>(create: (context) => NiveauBloc()),
  Provider<MatiersBloc>(create: (context) => MatiersBloc()),
];
