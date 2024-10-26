import 'dart:ui';

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';
import 'package:studify/src/courses/presentation/views/student_courses.dart';
import 'package:studify/src/etudiant/presentation/widgets/custom_student_app_bar.dart';
import 'package:studify/src/notification/presentation/views/student_notifications.dart';
import 'package:studify/src/profile/presentation/views/student_profile.dart';

import '../../../etudiant/presentation/views/etudiant_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final String role = "student";
  final Map<String, dynamic> _uis = {
    "student": {
      "appbar": [
        const CustomStudentAppBar(),
        const CustomAppBar(title: 'Courses'),
        const CustomAppBar(title: 'Notifications'),
        const CustomAppBar(title: 'Profile'),
      ],
      "pages": [
        const StudentHomeScreen(),
        const StudentCourses(),
        const StudentNotifications(),
        const StudentProfile(),
      ],
      "bottomNavigationBar": const [
        BottomNavigationBarItem(
          icon: Icon(EneftyIcons.home_bold),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(EneftyIcons.book_bold),
          label: 'Courses',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(EneftyIcons.message_bold),
        //   label: 'Inbox',
        // ),
        BottomNavigationBarItem(
          icon: Icon(EneftyIcons.notification_bold),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(EneftyIcons.profile_bold),
          label: 'Profile',
        ),
      ],
    },
    "professor": {
      "appbar": [],
      "pages": [],
      "bottomNavigationBar": [],
    },
    "admin": {
      "appbar": [],
      "pages": [],
      "bottomNavigationBar": [],
    },
  };

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
      appBar: _uis[role]["appbar"][_selectedIndex],
      body: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        child: _uis[role]["pages"][_selectedIndex],
      ),
      bottomNavigationBar: _buildFloatingBottomBar(),
    );
  }

  Widget _buildFloatingBottomBar() {
    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(30),
              border: Theme.of(context).brightness == Brightness.dark
                  ? Border.all(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1.0,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: BottomNavigationBar(
              selectedLabelStyle:
                  Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500,
                      ),
              unselectedLabelStyle:
                  Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500,
                      ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: _uis[role]["bottomNavigationBar"],
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
