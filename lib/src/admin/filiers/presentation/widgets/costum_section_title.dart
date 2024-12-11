import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSectionTitle extends StatelessWidget {
  final String title;
  final int? number;
  const BuildSectionTitle({
    super.key,
    required this.title,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'Molish',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
        ),
        number != null ? Text("($number)") : const SizedBox.shrink()
      ],
    );
  }
}
