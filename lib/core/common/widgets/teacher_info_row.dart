import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherInfoRow extends StatelessWidget {
  final String? teacher;
  final double? rating;

  const TeacherInfoRow({super.key, this.teacher, this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          teacher ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Mulish',
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF6B00),
              ),
        ),
        Row(
          children: [
            Icon(Icons.star, color: Colors.yellow, size: 16.sp),
            Text(
              rating?.toString() ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Mulish',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
