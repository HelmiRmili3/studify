import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/common/widgets/custom_app_bar.dart';
import '../../core/common/widgets/floating_bottom_bar.dart';
import 'courses/presentation/views/student_courses.dart';
import 'home/presentation/views/etudiant_home_screen.dart';
import 'home/presentation/widgets/custom_student_app_bar.dart';
import 'profile/presentation/views/student_profile.dart';

class EtudiantScreen extends StatefulWidget {
  const EtudiantScreen({super.key});

  @override
  State<EtudiantScreen> createState() => _EtudiantState();
}

class _EtudiantState extends State<EtudiantScreen> {
  int _selectedIndex = 0;

  final List<PreferredSizeWidget?> _appBar = [
    const CustomStudentAppBar(),
    const CustomAppBar(
      title: 'Courses',
      showBackButton: false,
    ),
    const CustomAppBar(
      title: 'Indox',
      showBackButton: false,
    ),
    const CustomAppBar(
      title: 'HomeWork',
      showBackButton: false,
    ),
    const CustomAppBar(
      title: 'Profile',
      showBackButton: false,
    ),
  ];

  final List<Widget> _pages = [
    const StudentHomeScreen(),
    const StudentCourses(),
    const Center(
      child: Text("This is inbox"),
    ),
    const Center(
      child: Text("This is HomeWork"),
    ),
    const StudentProfile(),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBar = const [
    BottomNavigationBarItem(icon: Icon(EneftyIcons.home_bold), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(EneftyIcons.book_bold), label: 'Courses'),
    BottomNavigationBarItem(
        icon: Icon(EneftyIcons.message_bold), label: 'Inbox'),
    BottomNavigationBarItem(
        icon: Icon(EneftyIcons.book_2_bold), label: 'HomeWork'),
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
