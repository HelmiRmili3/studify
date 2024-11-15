import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseTitle extends StatelessWidget {
  final String? course;

  const CourseTitle({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    return Text(
      course ?? '',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontFamily: 'Jost',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
