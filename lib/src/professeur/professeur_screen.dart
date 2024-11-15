import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/src/professeur/courses/presentation/views/professor_courses.dart';
import 'package:studify/src/professeur/home/presentation/views/professor_home.dart';
import 'package:studify/src/professeur/profile/presentation/views/professor_profile.dart';

import '../../core/common/widgets/custom_app_bar.dart';
import '../../core/common/widgets/floating_bottom_bar.dart';
import '../../core/common/widgets/custom_student_app_bar.dart';

class ProfessorScreen extends StatefulWidget {
  const ProfessorScreen({super.key});

  @override
  State<ProfessorScreen> createState() => _ProfesseurState();
}

class _ProfesseurState extends State<ProfessorScreen> {
  int _selectedIndex = 0;

  final List<PreferredSizeWidget?> _appBar = [
    CustomStudentAppBar(
      greeting: 'Hi',
      userName: 'Mariem',
      message: "What do you want to do today?",
      onNotificationPress: () {},
    ),
    const CustomAppBar(
      title: 'Courses',
      showBackButton: false,
    ),
    const CustomAppBar(
      title: 'Profile',
      showBackButton: false,
    ),
  ];

  final List<Widget> _pages = [
    const ProfessorHome(),
    const ProfessorCourses(),
    const ProfessorProfile(),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBar = const [
    BottomNavigationBarItem(icon: Icon(EneftyIcons.home_bold), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(EneftyIcons.book_bold), label: 'Courses'),
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
      appBar: _appBar[_selectedIndex],
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
