import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitchRow extends StatelessWidget {
  final String title;
  final bool switchValue;
  final ValueChanged<bool> onSwitchChanged;

  const CustomSwitchRow({
    super.key,
    required this.title,
    required this.switchValue,
    required this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title Text
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Mulish',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
          ),
          // Switch Toggle (Blue)
          Switch(
            value: switchValue,
            onChanged: onSwitchChanged,
            activeColor: Colors.blue, // Blue toggle
            inactiveThumbColor: Colors.grey, // Thumb when inactive
            inactiveTrackColor: Colors.grey.shade300, // Track when inactive
          ),
        ],
      ),
    );
  }
}
