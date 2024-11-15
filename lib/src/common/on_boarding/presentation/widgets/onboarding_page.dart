import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatelessWidget {
  final dynamic page;

  const OnboardingPage({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: 'Jost',
          fontSize: 24.sp,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.normal,
        );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 400.h,
          width: 300.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.grey[300],
          ),
          child: Image.asset(
            "${page["image"]}",
            width: 300.w,
            height: 400.h,
          ),
          // child: Icon(
          //   Icons.image,
          //   size: 50.sp,
          //   color: Colors.grey,
          // ),
        ),
        SizedBox(height: 10.h),
        Center(
          child: Text(
            page["title"],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Jost',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.normal,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
