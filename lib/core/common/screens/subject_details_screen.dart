import 'package:flutter/material.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';

class SubjectDetailsScreen extends StatefulWidget {
  const SubjectDetailsScreen({super.key});

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Subject Details'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('emtpy page'),
        ),
      ),
    );
  }
}
