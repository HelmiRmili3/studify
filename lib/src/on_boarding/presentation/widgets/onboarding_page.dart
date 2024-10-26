import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/theme/colors.dart';

class OnboardingPage extends StatelessWidget {
  final String text;

  const OnboardingPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24.sp,
          fontFamily: 'Jost',
          fontWeight: FontWeight.normal,
          color: AppColors.darkBleu,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
