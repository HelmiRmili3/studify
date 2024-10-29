import 'package:flutter/material.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';

import '../widgets/custom_switch_row.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Notification"),
      body: Column(
        children: [
          CustomSwitchRow(
            title: 'Notification',
            switchValue: true,
            onSwitchChanged: (value) {},
          ),
          CustomSwitchRow(
            title: 'Sound',
            switchValue: false,
            onSwitchChanged: (value) {},
          ),
          CustomSwitchRow(
            title: 'Vibration',
            switchValue: true,
            onSwitchChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
