import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'notification_icon.dart';

class CustomStudentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomStudentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      "Hi,",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                    ),
                    Text(
                      " Helmi",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  "What would you like to learn today?",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFamily: 'Mulish',
                        fontSize: 13.sp,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                ),
                Text(
                  "Search Below",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFamily: 'Mulish',
                        fontSize: 13.sp,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                ),
              ],
            ),
            NotificationIconWithCircle(
              onPress: () {},
              notificationCount: 7,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(110.h);
}
