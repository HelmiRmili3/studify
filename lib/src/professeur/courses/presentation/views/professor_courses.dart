import 'package:flutter/material.dart';

class ProfessorCourses extends StatefulWidget {
  const ProfessorCourses({super.key});

  @override
  State<ProfessorCourses> createState() => _ProfessorCoursesState();
}

class _ProfessorCoursesState extends State<ProfessorCourses> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This is Courses"),
    );
  }
}
