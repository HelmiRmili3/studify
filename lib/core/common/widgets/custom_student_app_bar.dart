import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../src/etudiant/home/presentation/widgets/notification_icon.dart';

class CustomStudentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String userName;
  final String? greeting;
  final String? message;
  final int notificationCount;
  final Function onNotificationPress;

  const CustomStudentAppBar({
    super.key,
    required this.userName,
    this.greeting,
    this.message,
    this.notificationCount = 0,
    required this.onNotificationPress,
  });

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
                    greeting != null
                        ? Text(
                            "$greeting,",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontFamily: 'Jost',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.sp,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                          )
                        : const SizedBox(),
                    Text(
                      " $userName",
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
                message != null
                    ? Text(
                        "$message",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontFamily: 'Mulish',
                              fontSize: 13.sp,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                      )
                    : SizedBox(height: 20.h),
              ],
            ),
            NotificationIconWithCircle(
              onPress: () => onNotificationPress(context),
              notificationCount: notificationCount,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.h);
}
