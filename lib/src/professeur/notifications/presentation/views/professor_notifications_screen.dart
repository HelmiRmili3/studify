import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../etudiant/notification/presentation/widgets/day_date.dart';
import '../../../../etudiant/notification/presentation/widgets/notifications_list.dart';

class ProfessorNotificationsScreen extends StatefulWidget {
  const ProfessorNotificationsScreen({super.key});

  @override
  State<ProfessorNotificationsScreen> createState() =>
      _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState
    extends State<ProfessorNotificationsScreen> {
  final notificationsByDay = {
    "Today": [
      NotificationItem(
        title: "New Category Course!",
        subtitle: "The 3D Design Course is Available.",
      ),
      NotificationItem(
        title: "Homework Reminder",
        subtitle: "Submit your assignment by tonight.",
      ),
    ],
    "Yesterday": [
      NotificationItem(
        title: "Quiz Announced",
        subtitle: "Prepare for the Math quiz tomorrow.",
      ),
    ],
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Notifications",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            left: 20.w,
            right: 20.w,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: notificationsByDay.length,
            itemBuilder: (context, index) {
              final day = notificationsByDay.keys.elementAt(index);
              final notifications = notificationsByDay[day]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DayDate(title: day),
                  SizedBox(height: 10.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: notifications.length,
                    itemBuilder: (context, notifIndex) {
                      return NotificationCard(
                        notification: notifications[notifIndex],
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
