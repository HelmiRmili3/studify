import 'package:provider/provider.dart';
import 'package:studify/core/common/blocs/theme/theme_bloc.dart';
import 'package:studify/src/admin/profile/presentation/bloc/users/users_bloc.dart';

import 'core/common/blocs/connectivity/connetivity_bloc.dart';
import 'core/common/blocs/theme/theme_event.dart';
import 'core/common/blocs/user/user_bloc.dart';
import 'src/admin/filiers/presentation/bloc/filieres/filiere_bloc.dart';
import 'src/admin/filiers/presentation/bloc/niveaux/niveau_bloc.dart';
import 'src/admin/profile/presentation/bloc/users/users_events.dart';
import 'src/common/auth/presentation/blocs/auth/auth_bloc.dart';
import 'src/common/auth/presentation/blocs/auth/auth_events.dart';
import 'src/common/on_boarding/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'src/etudiant/home/presentation/blocs/courses/courses_bloc.dart';
import 'src/etudiant/home/presentation/blocs/professors/professors_bloc.dart';
import 'src/professeur/courses/presentation/blocs/matiere/matiere_bloc.dart';
import 'src/professeur/home/presentation/blocs/filieres/professor_filieres_bloc.dart';
import 'src/professeur/home/presentation/blocs/home/home_bloc.dart';

List<Provider> porviders = [
  Provider<ThemeBloc>(create: (context) => ThemeBloc()..add(LoadThemeEvent())),
  Provider<OnboardingBloc>(create: (context) => OnboardingBloc(3)),
  Provider<AuthBloc>(create: (context) => AuthBloc()..add(AuthStarted())),
  Provider<UserBloc>(create: (context) => UserBloc()),
  Provider<FiliereBloc>(create: (context) => FiliereBloc()),
  Provider<NiveauBloc>(create: (context) => NiveauBloc()),
  Provider<UsersBloc>(create: (context) => UsersBloc()..add(FetchUsers())),
  Provider<HomeBloc>(create: (context) => HomeBloc()),
  Provider<ProfessorFilieresBloc>(create: (context) => ProfessorFilieresBloc()),
  Provider<CoursesBloc>(create: (context) => CoursesBloc()),
  Provider<ProfessorsBloc>(create: (context) => ProfessorsBloc()),
  Provider<ConnectivityBloc>(create: (context) => ConnectivityBloc()),
  Provider<MatiereBloc>(create: (context) => MatiereBloc()),
];
