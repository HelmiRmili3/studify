import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/utils/helpers.dart';
import 'package:studify/models/matiere.dart';

import '../screens/doc_deatils_screen.dart';

class CurriculumItem extends StatelessWidget {
  final Doc doc;
  final Matiere matiere;
  final String index;

  const CurriculumItem({
    super.key,
    required this.doc,
    required this.matiere,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocDetailsScreen(
              doc: doc,
              matiere: matiere,
            ),
          ),
        );
      },
      child: Container(
        height: 100.h,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor.withOpacity(.1),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Text(
                index,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Jost',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    maxLines: 2,
                    doc.title.capitalizeFirst(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Jost',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Files : ${doc.files.length}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Mulish',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    " Date : ${"${doc.date.toLocal()}".split(' ')[0]} Time : ${"${doc.date.toLocal()}".split(' ')[1].split('.')[0]}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Mulish',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.more_outlined,
              color: Colors.green,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
