import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayDate extends StatelessWidget {
  final String title;

  const DayDate({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Jost',
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
        ),
      ],
    );
  }
}
