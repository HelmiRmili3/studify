import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutTabContent extends StatelessWidget {
  const AboutTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Graphic Design is now a popular profession...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Mulish',
                  fontSize: 13.sp,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            "Graphic Design is a popular profession with growing opportunities...",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Mulish',
                  fontSize: 13.sp,
                ),
          ),
        ],
      ),
    );
  }
}
