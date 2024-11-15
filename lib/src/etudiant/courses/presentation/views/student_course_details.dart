import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/course_title.dart';
import '../widgets/tab_section.dart';
import '../widgets/teacher_info_row.dart';

class StudentCourseDetails extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const StudentCourseDetails({
    super.key,
    required this.arguments,
  });

  @override
  State<StudentCourseDetails> createState() => _StudentCourseDetailsState();
}

class _StudentCourseDetailsState extends State<StudentCourseDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set the status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(.2),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          flexibleSpace: Padding(
            padding: EdgeInsets.only(
              top: 80.h,
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                TeacherInfoRow(
                  teacher: widget.arguments['teacher'],
                  rating: widget.arguments['rating'],
                ),
                const SizedBox(height: 10.0),
                CourseTitle(course: widget.arguments['course']),
                const SizedBox(height: 10.0),
                CourseStats(
                  students: widget.arguments['students'].toString(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: TabSection(
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
