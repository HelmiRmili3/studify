import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/core/utils/helpers.dart';

import '../../../../../core/common/blocs/user/user_bloc.dart';
import '../../../../../core/common/blocs/user/user_event.dart';
import '../../../../../core/common/blocs/user/user_state.dart';
import '../../../../../core/common/widgets/costom_row.dart';
import '../../../../../core/common/widgets/logout_button.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../common/auth/presentation/blocs/auth/auth_bloc.dart';
import '../../../../common/auth/presentation/blocs/auth/auth_events.dart';
import '../../../../common/auth/presentation/blocs/auth/auth_states.dart';

class ProfessorProfile extends StatefulWidget {
  const ProfessorProfile({super.key});

  @override
  State<ProfessorProfile> createState() => _ProfessorProfileState();
}

class _ProfessorProfileState extends State<ProfessorProfile> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            GoRouter.of(context).go(RoutesNames.signin);
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserError) {
              return Center(child: Text(state.message));
            }

            if (state is UserLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 65.h, bottom: 100.h),
                  height: 600.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).splashColor,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: -50.h,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 140.h,
                              height: 140.h,
                              padding: EdgeInsets.all(4.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.green,
                                  width: 3.w,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 60.h,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(user.imageUrl),
                              ),
                            ),
                            Positioned(
                              bottom: 5.h,
                              right: 5.w,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 100.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${user.firstName.capitalizeFirst()} ${user.lastName.capitalizeFirst()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontFamily: 'Jost',
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              user.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontFamily: 'Mulish',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: 30.h),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 180.h,
                        left: 20.w,
                        right: 20.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomRow(
                              icon: EneftyIcons.profile_outline,
                              title: 'Edit Profile',
                              onTap: () {
                                context.push(RoutesNames.etudiantEditProfile);
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomRow(
                              icon: EneftyIcons.empty_wallet_outline,
                              title: 'Schedule',
                              onTap: () {
                                debugPrint('schedule');
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomRow(
                              icon: EneftyIcons.notification_outline,
                              title: 'Notifications',
                              onTap: () {
                                context.push(RoutesNames.notification);
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomRow(
                              icon: EneftyIcons.security_outline,
                              title: 'Security',
                              onTap: () {},
                            ),
                            SizedBox(height: 20.h),
                            CustomRow(
                              icon: EneftyIcons.language_circle_outline,
                              title: 'Language',
                              onTap: () {},
                            ),
                            SizedBox(height: 20.h),
                            CustomRow(
                              icon: EneftyIcons.eye_outline,
                              title: 'Dark Mode',
                              onTap: () {
                                context.push(RoutesNames.userThemeMode);
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomRow(
                              icon: EneftyIcons.security_outline,
                              title: 'Terms & Conditions',
                              onTap: () {},
                            ),
                            SizedBox(height: 20.h),
                            CustomRow(
                              icon: EneftyIcons.security_outline,
                              title: 'Help & Support',
                              onTap: () {},
                            ),
                            SizedBox(height: 20.h),
                            LogoutButton(
                              title: 'Disconnect',
                              onTap: () {
                                context.read<AuthBloc>().add(AuthLoggedOut());
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }
}
