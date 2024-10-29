import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/theme/colors.dart';

class OnboardingPage extends StatelessWidget {
  final String text;

  const OnboardingPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: 'Jost',
          fontSize: 24.sp,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.normal,
        );
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: 'Jost',
              fontSize: 24.sp,
              fontWeight: FontWeight.normal,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}