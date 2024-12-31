import 'package:get_it/get_it.dart';

import '../../src/admin/filiers/presentation/bloc/filieres/filiere_bloc.dart';
import '../../src/admin/filiers/presentation/bloc/niveaux/niveau_bloc.dart';
import '../../src/admin/profile/presentation/bloc/users/users_bloc.dart';
import '../../src/admin/profile/presentation/bloc/users/users_events.dart';
import '../../src/common/auth/presentation/blocs/auth/auth_bloc.dart';
import '../../src/common/auth/presentation/blocs/auth/auth_events.dart';
import '../../src/common/chats/presentation/blocs/chats/chats_bloc.dart';
import '../../src/common/chats/presentation/blocs/friends/friends_bloc.dart';
import '../../src/common/chats/presentation/blocs/friends/friends_events.dart';
import '../../src/common/on_boarding/presentation/blocs/onboarding/onboarding_bloc.dart';
import '../../src/etudiant/home/presentation/blocs/courses/courses_bloc.dart';
import '../../src/etudiant/home/presentation/blocs/professors/professors_bloc.dart';
import '../../src/professeur/courses/presentation/blocs/matiere/matiere_bloc.dart';
import '../../src/professeur/home/presentation/blocs/filieres/professor_filieres_bloc.dart';
import '../../src/professeur/home/presentation/blocs/home/home_bloc.dart';
import '../common/blocs/connectivity/connetivity_bloc.dart';
import '../common/blocs/theme/theme_bloc.dart';
import '../common/blocs/theme/theme_event.dart';
import '../common/blocs/user/user_bloc.dart';
import '../common/blocs/user/user_event.dart';

final locator = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    // Register BLoCs
    locator.registerLazySingleton<ThemeBloc>(
      () => ThemeBloc()..add(LoadThemeEvent()),
    );
    locator.registerLazySingleton<OnboardingBloc>(
      () => OnboardingBloc(3),
    );
    locator.registerLazySingleton<AuthBloc>(
      () => AuthBloc()..add(AuthStarted()),
    );
    locator.registerLazySingleton<UserBloc>(
      () => UserBloc()..add(FetchUser()),
    );
    locator.registerLazySingleton<FiliereBloc>(
      () => FiliereBloc(),
    );
    locator.registerLazySingleton<NiveauBloc>(
      () => NiveauBloc(),
    );
    locator.registerLazySingleton<UsersBloc>(
      () => UsersBloc()..add(FetchUsers()),
    );
    locator.registerLazySingleton<HomeBloc>(
      () => HomeBloc(),
    );
    locator.registerLazySingleton<ProfessorFilieresBloc>(
      () => ProfessorFilieresBloc(),
    );
    locator.registerLazySingleton<CoursesBloc>(
      () => CoursesBloc(),
    );
    locator.registerLazySingleton<ProfessorsBloc>(
      () => ProfessorsBloc(),
    );
    locator.registerLazySingleton<ConnectivityBloc>(
      () => ConnectivityBloc(),
    );
    locator.registerLazySingleton<MatiereBloc>(
      () => MatiereBloc(),
    );
    locator.registerLazySingleton<ChatsBloc>(
      () => ChatsBloc(),
    );
    locator.registerLazySingleton<FriendsBloc>(
      () => FriendsBloc(FetchFriends(filiereId: 'LAM1')),
    );
  }
}
