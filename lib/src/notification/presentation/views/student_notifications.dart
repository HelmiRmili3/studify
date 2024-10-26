import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/src/notification/presentation/widgets/day_date.dart';

class StudentNotifications extends StatefulWidget {
  const StudentNotifications({super.key});

  @override
  State<StudentNotifications> createState() => _StudentNotificationsState();
}

class _StudentNotificationsState extends State<StudentNotifications> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DayDate(title: "Today"),
        SizedBox(height: 20.h),
        Container(
          height: 100.h,
          decoration: BoxDecoration(
            color: const Color(0XFFE8F1FF),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: Colors.grey.withOpacity(.1),
              width: 2,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                SizedBox(width: 10.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Category Course.!",
                      // style: Theme.of(context).textTheme.titleMedium?.copyWith(

                      //     ),
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                    Text(
                      "New the 3D Design Course is Availa..",
                      // style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      //       fontFamily: 'Mulish',
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 12.sp,
                      //       color: Color(0XFF545454),
                      //     ),
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                        color: const Color(0XFF545454),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
