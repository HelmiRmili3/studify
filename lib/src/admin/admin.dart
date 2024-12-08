import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/common/blocs/user/user_bloc.dart';
import '../../core/common/blocs/user/user_event.dart';
import '../../core/common/blocs/user/user_state.dart';
import '../../core/common/widgets/custom_app_bar.dart';
import '../../core/common/widgets/floating_bottom_bar.dart';
import '../../core/common/widgets/custom_student_app_bar.dart';
import '../../core/routes/route_names.dart';
import 'filiers/presentation/views/filieres_list.dart';
import 'profile/presentation/views/admin_profile.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
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
              return const CustomAppBar(
                title: 'Loading...',
                showBackButton: false,
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
                      .pushNamed(RoutesNames.adminNotificationsScreen);
                },
              );
            }
            if (state is UserError) {
              return const CustomAppBar(
                title: 'Error',
                showBackButton: false,
              );
            }
            return const CustomAppBar(
              title: 'Loading...',
              showBackButton: false,
            );
          },
        ),
      );
    }
    return _appBar[index]!;
  }

  final List<PreferredSizeWidget?> _appBar = [
    null,
    const CustomAppBar(title: 'Profile', showBackButton: false),
  ];

  final List<Widget> _pages = [
    const AdminFiliers(),
    const AdminProfile(),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBar = const [
    BottomNavigationBarItem(
        icon: Icon(EneftyIcons.book_bold), label: 'Filières'),
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
