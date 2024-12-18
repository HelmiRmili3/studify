import 'package:flutter/material.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';

import '../../../models/matiere.dart';

class DocDetailsScreen extends StatelessWidget {
  final Doc doc;
  const DocDetailsScreen({
    super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: doc.title),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(doc.message),
        ),
      ),
    );
  }
}
