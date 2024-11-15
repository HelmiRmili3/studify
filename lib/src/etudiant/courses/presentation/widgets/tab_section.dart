import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/src/etudiant/courses/presentation/widgets/curriculum_item.dart';

import 'about_tab_content.dart';
import 'curriculum_tab_content.dart';

class TabSection extends StatefulWidget {
  final TabController controller;

  const TabSection({super.key, required this.controller});

  @override
  TabSectionState createState() => TabSectionState();
}

class TabSectionState extends State<TabSection> {
  final List<CurriculumItem> curriculum = [
    const CurriculumItem(
        title: "Introduction to Flutter", time: "20 Mins", index: "01"),
    const CurriculumItem(
        title: "Understanding Dart Basics", time: "25 Mins", index: "02"),
    const CurriculumItem(
        title: "Building Layouts in Flutter", time: "15 Mins", index: "03"),
    const CurriculumItem(
        title: "State Management", time: "30 Mins", index: "04"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: widget.controller,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'Mulish',
                fontSize: 15.sp,
              ),
          tabs: const [
            Tab(text: 'Curriculum'),
            Tab(text: 'About'),
          ],
        ),
        SizedBox(
          height: 550.h,
          child: TabBarView(
            controller: widget.controller,
            children: [
              CurriculumTabContent(curriculum: curriculum),
              const AboutTabContent(),
            ],
          ),
        ),
      ],
    );
  }
}

class CourseStats extends StatelessWidget {
  final String? students;

  const CourseStats({super.key, this.students});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.group, color: const Color(0xFFFF6B00), size: 16.sp),
        const SizedBox(width: 5.0),
        Text(
          '$students student',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'Jost',
                fontSize: 14.sp,
              ),
        ),
        const SizedBox(width: 10.0),
        Container(width: 2, height: 16.h, color: Colors.black),
        const SizedBox(width: 10.0),
        Icon(Icons.access_time, color: const Color(0xFFFF6B00), size: 16.sp),
        const SizedBox(width: 5.0),
        Text(
          '22 Hours',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'Mulish',
                fontSize: 14.sp,
              ),
        ),
      ],
    );
  }
}
