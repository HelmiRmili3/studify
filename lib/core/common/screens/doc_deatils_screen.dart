import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';
import 'package:studify/core/utils/helpers.dart';
import '../../../models/matiere.dart';

class DocDetailsScreen extends StatelessWidget {
  final Doc doc;
  final Matiere matiere;

  const DocDetailsScreen({
    super.key,
    required this.doc,
    required this.matiere,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: matiere.name),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Text(
              doc.title.capitalizeFirst(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Jost',
                    fontSize: 18.sp,
                  ),
            ),
            const SizedBox(height: 8.0),

            // Date and Creator Info
            Row(
              children: [
                const SizedBox(width: 4.0),
                Icon(Icons.calendar_today, color: Colors.grey[600]),
                const SizedBox(width: 4.0),
                Text(
                  "${doc.date.toLocal()}".split(' ')[0],
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Divider
            Divider(color: Colors.grey[300]),

            // Message Section
            Text(
              doc.message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    color: Colors.grey[800],
                  ),
            ),
            const SizedBox(height: 16.0),

            // Files Section
            if (doc.files.isNotEmpty) ...[
              Divider(color: Colors.grey[300]),
              Text(
                'Attached Files',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: doc.files.length,
                itemBuilder: (context, index) {
                  final file = doc.files[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                    leading: Icon(
                      Icons.insert_drive_file,
                      color: Colors.blue[300],
                    ),
                    title: Text(
                      file.fileName,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () {
                        // Add download functionality here
                      },
                    ),
                  );
                },
              ),
            ] else
              Center(
                child: Text(
                  'No attached files.',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
