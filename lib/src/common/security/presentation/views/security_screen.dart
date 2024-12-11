import 'package:flutter/material.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';

import '../../../../etudiant/notification/presentation/widgets/custom_switch_row.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Security'),
      body: Column(
        children: [
          CustomSwitchRow(
            title: 'Remember me',
            switchValue: true,
            onSwitchChanged: (value) {},
          ),
          CustomSwitchRow(
            title: 'Biometrics ID',
            switchValue: false,
            onSwitchChanged: (value) {},
          ),
          CustomSwitchRow(
            title: 'Face ID',
            switchValue: true,
            onSwitchChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
