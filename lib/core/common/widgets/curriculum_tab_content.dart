import 'package:flutter/material.dart';
import 'package:studify/src/etudiant/courses/presentation/widgets/curriculum_item.dart';

import '../../../src/etudiant/courses/presentation/widgets/professor_Non_Scrollable_dynamic_list.dart';

class CurriculumTabContent extends StatelessWidget {
  final List<Map<String, dynamic>> curriculum;

  const CurriculumTabContent({
    super.key,
    required this.curriculum,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: ProfessorNonScrollableDynamicList(
            items: curriculum,
            itemBuilder: (item) => CurriculumItem(
              title: item['title'] ?? 'Untitled',
              time: item['time'] ?? 'Unknown',
              index: item['index'] ?? '0',
            ),
          ),
        ),
      ],
    );
  }
}
