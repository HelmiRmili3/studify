import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap; // Added onTap

  const CustomRow({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Ensures ripple effect is visible
      child: InkWell(
        onTap: onTap,
        splashColor: Theme.of(context)
            .primaryColor
            .withOpacity(0.3), // Customize ripple color
        borderRadius:
            BorderRadius.circular(8.r), // Optional: for rounded ripple
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 20.w,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Mulish',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
