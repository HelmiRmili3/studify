import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'about_tab_content.dart';
import 'curriculum_tab_content.dart';

class TabSection extends StatefulWidget {
  final TabController controller;

  const TabSection({super.key, required this.controller});

  @override
  TabSectionState createState() => TabSectionState();
}

class TabSectionState extends State<TabSection> {
  final List<Map<String, dynamic>> curriculum = [
    {
      "title": "Introduction to Flutter",
      "time": "10:00 AM - 11:30 AM",
      "description":
          "Overview of Flutter, its capabilities, and how it compares to other frameworks."
    },
    {
      "title": "Dart Basics",
      "time": "12:00 PM - 1:30 PM",
      "description":
          "Introduction to Dart programming language, syntax, and core concepts."
    },
    {
      "title": "Building UI in Flutter",
      "time": "2:00 PM - 3:30 PM",
      "description":
          "Learn how to create widgets, layouts, and implement responsive designs."
    },
    {
      "title": "State Management with Provider",
      "time": "4:00 PM - 5:30 PM",
      "description":
          "Understanding state management principles and using Provider to manage app state."
    },
    {
      "title": "State Management with Provider",
      "time": "4:00 PM - 5:30 PM",
      "description":
          "Understanding state management principles and using Provider to manage app state."
    },
    {
      "title": "State Management with Provider",
      "time": "4:00 PM - 5:30 PM",
      "description":
          "Understanding state management principles and using Provider to manage app state."
    },
    {
      "title": "State Management with Provider",
      "time": "4:00 PM - 5:30 PM",
      "description":
          "Understanding state management principles and using Provider to manage app state."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: widget.controller,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'Mulish',
                fontSize: 15.sp.clamp(12, 18),
              ),
          tabs: const [
            Tab(text: 'Curriculum'),
            Tab(text: 'About'),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height *
              0.7, // Provide a fixed height
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
        Icon(
          Icons.group,
          color: const Color(0xFFFF6B00),
          size: 16.sp.clamp(12, 20), // Ensure scaling for small screens
        ),
        const SizedBox(width: 5.0),
        Flexible(
          child: Text(
            '$students student',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Jost',
                  fontSize: 14.sp.clamp(10, 18),
                ),
            overflow: TextOverflow.ellipsis, // Truncate text if needed
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 10.0),
        Container(
          width: 2,
          height: 16.h,
          color: Colors.black,
        ),
        const SizedBox(width: 10.0),
        Icon(
          Icons.access_time,
          color: const Color(0xFFFF6B00),
          size: 16.sp.clamp(12, 20),
        ),
        const SizedBox(width: 5.0),
        Flexible(
          child: Text(
            '22 Hours',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Mulish',
                  fontSize: 14.sp.clamp(10, 18),
                ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
