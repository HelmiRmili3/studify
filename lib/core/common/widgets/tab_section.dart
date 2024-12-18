import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/core/common/widgets/fading_circle_loading_indicator.dart';
import 'package:studify/core/utils/firestore_filter_model.dart';
import 'package:studify/models/matiere.dart';
import 'package:studify/src/professeur/courses/presentation/blocs/matiere/matiere_events.dart';

import '../../../src/professeur/courses/presentation/blocs/matiere/matiere_bloc.dart';
import '../../../src/professeur/courses/presentation/blocs/matiere/matiere_states.dart';
import 'about_tab_content.dart';
import 'curriculum_tab_content.dart';

class TabSection extends StatefulWidget {
  final TabController controller;
  final Matiere matiere;

  const TabSection({
    super.key,
    required this.controller,
    required this.matiere,
  });

  @override
  TabSectionState createState() => TabSectionState();
}

class TabSectionState extends State<TabSection> {
  @override
  void initState() {
    super.initState();

    context.read<MatiereBloc>().add(LoadDocs(filters: [
          FirestoreFilter(field: 'matiereId', value: widget.matiere.id),
          FirestoreFilter(field: 'creator', value: widget.matiere.professor),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatiereBloc, MatiereStates>(
      builder: (context, state) {
        if (state is MatiereLoading) {
          return const Center(
            child: FadingCircleLoadingIndicator(),
          );
        }
        if (state is MatiereLoaded) {
          state.docs.sort((a, b) => a.date.compareTo(b.date));

          debugPrint("Docs =============> ${state.docs.length.toString()}");
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                controller: widget.controller,
                labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Mulish',
                      fontSize: 15.sp.clamp(12, 18),
                    ),
                tabs: const [
                  Tab(text: 'Curriculum'),
                  Tab(text: 'About'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: TabBarView(
                  controller: widget.controller,
                  children: [
                    CurriculumTabContent(
                      docs: state.docs,
                    ),
                    const AboutTabContent(),
                  ],
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class CourseStats extends StatelessWidget {
  final String? students;

  const CourseStats({super.key, this.students});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.group,
          color: const Color(0xFFFF6B00),
          size: 16.sp.clamp(12, 20),
        ),
        const SizedBox(width: 5.0),
        Flexible(
          child: Text(
            '$students student',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Jost',
                  fontSize: 14.sp.clamp(10, 18),
                ),
            overflow: TextOverflow.ellipsis, // Truncate text if needed
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 10.0),
        Container(
          width: 2,
          height: 16.h,
          color: Colors.black,
        ),
        const SizedBox(width: 10.0),
        Icon(
          Icons.access_time,
          color: const Color(0xFFFF6B00),
          size: 16.sp.clamp(12, 20),
        ),
        const SizedBox(width: 5.0),
        Flexible(
          child: Text(
            '22 Hours',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Mulish',
                  fontSize: 14.sp.clamp(10, 18),
                ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
