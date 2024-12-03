import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/src/common/auth/domain/entities/user_email_entity.dart';

class UserCard extends StatelessWidget {
  final UserEmailEntity user;
  final VoidCallback onDelete;

  const UserCard({
    super.key,
    required this.user,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      height: 100.h,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: Colors.grey.withOpacity(.1),
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile avatar
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: const Icon(
              EneftyIcons.personalcard_bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10.w),
          // Name and email
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.email,
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                    color: const Color(0XFF545454),
                  ),
                ),
              ],
            ),
          ),
          // Delete button
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              EneftyIcons.trash_bold,
              color: Colors.red.withOpacity(0.8),
              size: 24.r,
            ),
          ),
        ],
      ),
    );
  }
}
