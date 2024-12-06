import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/utils/helpers.dart';
import 'package:studify/models/user.dart';

import '../../../src/etudiant/home/presentation/widgets/notification_icon.dart';

class CustomStudentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final UserModel user;
  final String? greeting;
  final String? message;
  final int notificationCount;
  final Function onNotificationPress;

  const CustomStudentAppBar({
    super.key,
    required this.user,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      width: 60,
                      height: 60,
                      user.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          " ${user.firstName}".capitalizeFirst(),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontFamily: 'Jost',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.sp,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    message != null
                        ? Text(
                            "$message",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontFamily: 'Mulish',
                                  fontSize: 13.sp,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                          )
                        : SizedBox(height: 20.h),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: NotificationIconWithCircle(
                onPress: () => onNotificationPress(context),
                notificationCount: notificationCount,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.h);
}
