import 'package:flutter/material.dart';
import 'package:studify/core/common/widgets/curriculum_item.dart';
import 'package:studify/models/matiere.dart';

import '../../../src/professeur/courses/presentation/widgets/professor_non_scrollable_dynamic_list.dart';

class CurriculumTabContent extends StatelessWidget {
  final List<Doc> docs;

  const CurriculumTabContent({
    super.key,
    required this.docs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: ProfessorNonScrollableDynamicList(
            items: docs,
            itemBuilder: (doc) => CurriculumItem(
              doc: doc,
              index: "${docs.indexOf(doc) + 1}",
            ),
          ),
        ),
      ],
    );
  }
}
