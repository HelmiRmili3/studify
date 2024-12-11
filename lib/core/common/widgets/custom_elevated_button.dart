import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry? padding;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon = Icons.arrow_forward_sharp,
    required this.backgroundColor,
    required this.foregroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0.r),
        ),
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 16.0.w,
              vertical: 6.0.h,
            ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (text != null)
            Text(
              text!,
              style: TextStyle(
                color: foregroundColor,
                fontFamily: 'Jost',
                fontSize: 18.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (text != null) SizedBox(width: 8.0.w),
          Container(
            decoration: BoxDecoration(
              color: foregroundColor,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(6.0.w),
            child: Icon(
              icon,
              color: backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
