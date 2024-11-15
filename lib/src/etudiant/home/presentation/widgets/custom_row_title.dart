import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRowTitle extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const CustomRowTitle({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Text(
            'View All',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'Mulish',
                  fontSize: 13.sp,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
