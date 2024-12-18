import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/core/utils/enums.dart';
import 'package:studify/models/matiere.dart';
import 'package:studify/src/admin/notifications/presentation/views/admin_notifications_screen.dart';
import 'package:studify/src/admin/profile/presentation/views/add_new_users.dart';
import 'package:studify/src/app.dart';
import 'package:studify/src/common/security/presentation/views/security_screen.dart';
import 'package:studify/src/common/terms&conditions/presentation/views/terms_and_conditions_screen.dart';
import 'package:studify/src/professeur/courses/presentation/views/professor_add_new_doc.dart';
import 'package:studify/src/professeur/courses/presentation/views/professor_matiere_details.dart';
import 'package:studify/src/professeur/notifications/presentation/views/professor_notifications_screen.dart';

import '../../src/common/auth/presentation/views/create_new_password_screen.dart';
import '../../src/common/auth/presentation/views/fill_your_profile_screen.dart';
import '../../src/common/auth/presentation/views/forget_password_screen.dart';
import '../../src/common/auth/presentation/views/signin_screen.dart';
import '../../src/common/auth/presentation/views/signup_screen.dart';
import '../../src/common/mode/presentation/views/user_theme_mode.dart';
import '../../src/common/on_boarding/presentation/views/on_boarding_screen.dart';
import '../../src/common/splash/presentation/views/splash_screen.dart';
import '../../src/etudiant/courses/presentation/views/student_course_details.dart';
import '../../src/etudiant/courses/presentation/views/student_courses.dart';
import '../../src/etudiant/etudiant_screen.dart';
import '../../src/common/notifications/presentation/views/notification_screen.dart';
import '../../src/etudiant/notification/presentation/views/student_notifications.dart';
import '../../src/professeur/courses/presentation/views/professor_courses.dart';
import '../common/screens/edit_profile.dart';
import '../../src/professeur/professeur_screen.dart';
import '../common/screens/error_role_ot_found.dart';
import '../common/screens/full_display_image_screen.dart';
import 'route_names.dart';

class AppRouter {
  static GoRouter router = _buildRouter();

  static GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: RoutesNames.splash,
      errorPageBuilder: (context, state) => MaterialPage(
        child: Scaffold(
          body: Center(
            child: Text(state.error.toString()),
          ),
        ),
      ),
      routes: [
        GoRoute(
          name: RoutesNames.splash,
          path: RoutesNames.splash,
          pageBuilder: (context, state) => _fadeTransition(
            state,
            const SplashScreen(),
          ),
        ),
        GoRoute(
          path: RoutesNames.authenticationHandler,
          name: RoutesNames.authenticationHandler,
          pageBuilder: (context, state) => _fadeTransition(
            state,
            AuthenticationHandler(
              isFirstTime: state.extra as bool,
            ),
          ),
        ),
        GoRoute(
          name: RoutesNames.onboarding,
          path: RoutesNames.onboarding,
          pageBuilder: (context, state) => _fadeTransition(
            state,
            const OnboardingScreen(),
          ),
        ),
        GoRoute(
          path: RoutesNames.signin,
          name: RoutesNames.signin,
          pageBuilder: (context, state) => _slideTransition(
            state,
            const SigninScreen(),
            const Offset(1, 0),
          ),
        ),
        GoRoute(
          path: RoutesNames.app,
          name: RoutesNames.app,
          pageBuilder: (context, state) {
            final role = state.extra as UserRole?;
            if (role == null) {
              return const MaterialPage(
                child: RoleNotFoundErrorScreen(),
              );
            }
            return slideTransition(
              state,
              App(
                role: role,
              ),
            );
          },
        ),
        GoRoute(
          path: RoutesNames.signup,
          name: RoutesNames.signup,
          pageBuilder: (context, state) => _slideTransition(
            state,
            const SignupScreen(),
            const Offset(0, -1),
          ),
        ),
        GoRoute(
          path: RoutesNames.fillYourProfile,
          name: RoutesNames.fillYourProfile,
          pageBuilder: (context, state) => slideTransition(
            state,
            FillYourProfileScreen(
              arguments: state.extra as Map<String, dynamic>,
            ),
          ),
        ),
        GoRoute(
          path: RoutesNames.forgotPassword,
          name: RoutesNames.forgotPassword,
          pageBuilder: (context, state) => slideTransition(
            state,
            const ForgetPasswordScreen(),
          ),
        ),
        GoRoute(
          path: RoutesNames.resetPassword,
          name: RoutesNames.resetPassword,
          pageBuilder: (context, state) => slideTransition(
            state,
            const CreateNewPasswordScreen(),
          ),
        ),
        GoRoute(
          path: RoutesNames.etudiant,
          name: RoutesNames.etudiant,
          pageBuilder: (context, state) => slideTransition(
            state,
            const EtudiantScreen(),
          ),
        ),
        GoRoute(
          path: RoutesNames.etudiantNotifications,
          name: RoutesNames.etudiantNotifications,
          pageBuilder: (context, state) => slideTransition(
            state,
            const StudentNotifications(),
          ),
        ),
        GoRoute(
          path: RoutesNames.professor,
          name: RoutesNames.professor,
          pageBuilder: (context, state) => slideTransition(
            state,
            const ProfessorScreen(),
          ),
        ),
        GoRoute(
          path: RoutesNames.professorMatiereDetailes,
          name: RoutesNames.professorMatiereDetailes,
          pageBuilder: (context, state) => slideTransition(
            state,
            ProfessorMatiereDetails(
                arguments: state.extra as Map<String, dynamic>),
          ),
        ),
        GoRoute(
          path: RoutesNames.etudiantEditProfile,
          name: RoutesNames.etudiantEditProfile,
          pageBuilder: (context, state) => slideTransition(
            state,
            const StudentEditProfile(),
          ),
        ),
        GoRoute(
          path: RoutesNames.notification,
          name: RoutesNames.notification,
          pageBuilder: (context, state) => slideTransition(
            state,
            const NotificationScreen(),
          ),
        ),
        GoRoute(
          path: RoutesNames.userThemeMode,
          name: RoutesNames.userThemeMode,
          pageBuilder: (context, state) => slideTransition(
            state,
            const UserThemeMode(),
          ),
        ),
        GoRoute(
          path: RoutesNames.etudiantCourseDetails,
          name: RoutesNames.etudiantCourseDetails,
          pageBuilder: (context, state) => slideTransition(
            state,
            StudentCourseDetails(
              arguments: state.extra as Matiere,
            ),
          ),
        ),
        GoRoute(
          name: RoutesNames.addnewuser,
          path: RoutesNames.addnewuser,
          pageBuilder: (context, state) => _fadeTransition(
            state,
            const AddNewUsers(),
          ),
        ),
        GoRoute(
          path: RoutesNames.adminNotificationsScreen,
          name: RoutesNames.adminNotificationsScreen,
          pageBuilder: (context, state) => _slideTransition(
            state,
            const AdminNotificationsScreen(),
            const Offset(1, 0),
          ),
        ),
        GoRoute(
          path: RoutesNames.professorNotificationsScreen,
          name: RoutesNames.professorNotificationsScreen,
          pageBuilder: (context, state) => _slideTransition(
            state,
            const ProfessorNotificationsScreen(),
            const Offset(1, 0),
          ),
        ),
        GoRoute(
          path: RoutesNames.fullDisplayImageScreen,
          name: RoutesNames.fullDisplayImageScreen,
          pageBuilder: (context, state) => _fadeTransition(
            state,
            FullDisplayImageScreen(
              image: state.extra as String,
            ),
          ),
        ),
        GoRoute(
          path: RoutesNames.professorAddNewDoc,
          name: RoutesNames.professorAddNewDoc,
          pageBuilder: (context, state) => _fadeTransition(
            state,
            ProfessorAddNewDoc(
              arguments: state.extra as Map<String, dynamic>,
            ),
          ),
        ),
        // GoRoute(
        //   path: RoutesNames.subjectDetailsScreen,
        //   name: RoutesNames.subjectDetailsScreen,
        //   pageBuilder: (context, state) => _fadeTransition(
        //     state,
        //     DocDetailsScreen(doc: null,),
        //   ),
        // ),
        GoRoute(
          path: RoutesNames.securityscreen,
          name: RoutesNames.securityscreen,
          pageBuilder: (context, state) => _fadeTransition(
            state,
            const SecurityScreen(),
          ),
        ),
        GoRoute(
          path: RoutesNames.termsandconditions,
          name: RoutesNames.termsandconditions,
          pageBuilder: (context, state) => _fadeTransition(
            state,
            const TermsAndConditionsScreen(),
          ),
        ),
        GoRoute(
          path: RoutesNames.professorCourses,
          name: RoutesNames.professorCourses,
          pageBuilder: (context, state) => _fadeTransition(
            state,
            ProfessorCourses(category: state.extra as String),
          ),
        ),
        GoRoute(
          path: RoutesNames.etudiantCourses,
          name: RoutesNames.etudiantCourses,
          pageBuilder: (context, state) => _fadeTransition(
            state,
            StudentCourses(
              category: state.extra as String,
            ),
          ),
        ),
      ],
    );
  }

  static CustomTransitionPage _fadeTransition(
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static CustomTransitionPage _slideTransition(
    GoRouterState state,
    Widget child,
    Offset beginOffset,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        final tween = Tween(begin: beginOffset, end: Offset.zero)
            .chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  static CustomTransitionPage<void> slideTransition(
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide in from the right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
