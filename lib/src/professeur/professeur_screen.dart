import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/core/common/widgets/fading_circle_loading_indicator.dart';
import 'package:studify/src/professeur/home/presentation/views/professor_home.dart';
import 'package:studify/src/professeur/profile/presentation/views/professor_profile.dart';

import '../../core/common/blocs/user/user_bloc.dart';
import '../../core/common/blocs/user/user_event.dart';
import '../../core/common/blocs/user/user_state.dart';
import '../../core/common/widgets/custom_app_bar.dart';
import '../../core/common/widgets/floating_bottom_bar.dart';
import '../../core/common/widgets/custom_student_app_bar.dart';
import '../../core/routes/route_names.dart';

class ProfessorScreen extends StatefulWidget {
  const ProfessorScreen({super.key});

  @override
  State<ProfessorScreen> createState() => _ProfesseurState();
}

class _ProfesseurState extends State<ProfessorScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUser());
  }

  int _selectedIndex = 0;

  PreferredSizeWidget? _buildAppBar(BuildContext context, int index) {
    if (index == 0) {
      return PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const FadingCircleLoadingIndicator();
            }
            if (state is UserError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is UserLoaded) {
              final user = state.user;
              return CustomStudentAppBar(
                greeting: 'Hi',
                user: user,
                message: "What do you want to do today?",
                notificationCount: 7,
                onNotificationPress: (context) {
                  GoRouter.of(context)
                      .pushNamed(RoutesNames.professorNotificationsScreen);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );
    }
    return _appBar[index]!;
  }

  final List<PreferredSizeWidget?> _appBar = [
    null,
    const CustomAppBar(title: 'Indox', showBackButton: false),
    const CustomAppBar(title: 'Profile', showBackButton: false),
  ];

  final List<Widget> _pages = [
    const ProfessorHome(),
    // const ProfessorCourses(),
    const Center(
      child: Text('This indox page'),
    ),
    const ProfessorProfile(),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBar = const [
    BottomNavigationBarItem(icon: Icon(EneftyIcons.home_bold), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(EneftyIcons.message_bold), label: 'Indox'),
    BottomNavigationBarItem(
        icon: Icon(EneftyIcons.profile_bold), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );

    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(context, _selectedIndex),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: 20.w,
          right: 20.w,
        ),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: FloatingBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _bottomNavigationBar,
      ),
    );
  }
}
