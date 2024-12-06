import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/src/etudiant/courses/presentation/widgets/curriculum_item.dart';

class CurriculumTabContent extends StatelessWidget {
  final List<CurriculumItem> curriculum;

  const CurriculumTabContent({
    super.key,
    required this.curriculum,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Section 01",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Jost',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
                children: curriculum.map((item) {
              return CurriculumItem(
                title: item.title,
                time: item.time,
                index: item.index,
              );
            }).toList()),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
