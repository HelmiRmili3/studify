import 'package:provider/provider.dart';
import 'package:studify/core/common/blocs/theme/theme_bloc.dart';
import 'package:studify/src/admin/profile/presentation/bloc/users/users_bloc.dart';
import 'package:studify/src/common/chats/presentation/blocs/friends/friends_bloc.dart';

import 'core/common/blocs/connectivity/connetivity_bloc.dart';
import 'core/common/blocs/user/user_bloc.dart';
import 'core/injection/dependency_injection.dart';
import 'src/admin/filiers/presentation/bloc/filieres/filiere_bloc.dart';
import 'src/admin/filiers/presentation/bloc/niveaux/niveau_bloc.dart';
import 'src/common/auth/presentation/blocs/auth/auth_bloc.dart';
import 'src/common/chats/presentation/blocs/chats/chats_bloc.dart';
import 'src/common/on_boarding/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'src/etudiant/home/presentation/blocs/courses/courses_bloc.dart';
import 'src/etudiant/home/presentation/blocs/professors/professors_bloc.dart';
import 'src/professeur/courses/presentation/blocs/matiere/matiere_bloc.dart';
import 'src/professeur/home/presentation/blocs/filieres/professor_filieres_bloc.dart';
import 'src/professeur/home/presentation/blocs/home/home_bloc.dart';

List<Provider> porviders = [
  Provider<ThemeBloc>(create: (_) => locator<ThemeBloc>()),
  Provider<OnboardingBloc>(create: (_) => locator<OnboardingBloc>()),
  Provider<AuthBloc>(create: (_) => locator<AuthBloc>()),
  Provider<UserBloc>(create: (_) => locator<UserBloc>()),
  Provider<FiliereBloc>(create: (_) => locator<FiliereBloc>()),
  Provider<NiveauBloc>(create: (_) => locator<NiveauBloc>()),
  Provider<UsersBloc>(create: (_) => locator<UsersBloc>()),
  Provider<HomeBloc>(create: (_) => locator<HomeBloc>()),
  Provider<ProfessorFilieresBloc>(
      create: (_) => locator<ProfessorFilieresBloc>()),
  Provider<CoursesBloc>(create: (_) => locator<CoursesBloc>()),
  Provider<ProfessorsBloc>(create: (_) => locator<ProfessorsBloc>()),
  Provider<ConnectivityBloc>(create: (_) => locator<ConnectivityBloc>()),
  Provider<MatiereBloc>(create: (_) => locator<MatiereBloc>()),
  Provider<ChatsBloc>(create: (_) => locator<ChatsBloc>()),
  Provider<FriendsBloc>(create: (_) => locator<FriendsBloc>()),
];
