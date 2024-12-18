import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/core/common/widgets/fading_circle_loading_indicator.dart';
import 'package:studify/core/routes/route_names.dart';
import 'package:studify/src/etudiant/home/presentation/blocs/courses/courses_states.dart';
import 'package:studify/src/etudiant/home/presentation/widgets/matiere_loading_effect.dart';

import '../../../../../core/common/widgets/custom_search_filed.dart';
import '../../../../../models/card_data.dart';
import '../blocs/courses/courses_bloc.dart';
import '../blocs/courses/courses_events.dart';
import '../blocs/professors/professors_bloc.dart';
import '../blocs/professors/professors_events.dart';
import '../blocs/professors/professors_states.dart';
import '../widgets/custom_row_title.dart';
import '../widgets/horizontal_category_list.dart';
import '../widgets/schedule_list_card.dart';
import '../widgets/courses_list.dart';
import '../widgets/professors_list.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _EtudiantHomeScreenState();
}

class _EtudiantHomeScreenState extends State<StudentHomeScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<CoursesBloc>().add(LoadMatieres());
    context.read<ProfessorsBloc>().add(LoadProfessors());
  }

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );

    List<String> categories = [
      'All',
      'Courses',
      'Travaux dirigé',
      'Travaux pratiques',
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomSearchField(
            prefixIcon: EneftyIcons.search_normal_2_outline,
            suffixIcon: EneftyIcons.setting_3_outline,
            hintText: 'Search for..',
            controller: searchController,
          ),
          SizedBox(height: 20.h),
          ScheduleListCard(
            imageUrl: 'assets/images/homebg.png',
            cards: [
              CardData(
                time: '09:55 - 11:25',
                course: 'CI Préparation TOEIC',
                instructor: 'Mounira Jabnoune',
                location: 'LabLangues',
                onTap: () {},
              ),
              CardData(
                time: '11:30 - 13:00',
                course: 'Advanced Mathematics',
                instructor: 'Ali Ben Salem',
                location: 'Room 203',
                onTap: () {
                  debugPrint('Card 2 tapped');
                },
              ),
              CardData(
                time: '13:30 - 15:00',
                course: 'Computer Science 101',
                instructor: 'Sami Trabelsi',
                location: 'Computer Lab',
                onTap: () {
                  debugPrint('Card 3 tapped');
                },
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            'Categories',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
          ),
          SizedBox(height: 20.h),
          HorizontalCategoryList(
            categories: categories,
            onCategoryTap: (category) {
              debugPrint('$category Clicked');
              GoRouter.of(context).push(
                RoutesNames.etudiantCourses,
                extra: category,
              );
            },
          ),
          SizedBox(height: 20.h),
          CustomRowTitle(
              title: "Popular Courses",
              onViewAll: () {
                GoRouter.of(context).push(
                  RoutesNames.etudiantCourses,
                  extra: 'All',
                );
              }),
          SizedBox(height: 20.h),
          BlocBuilder<CoursesBloc, CoursesStates>(
            builder: (context, state) {
              if (state is MatieresLoading) {
                return const Center(child: ShimmerCard());
              } else if (state is MatieresLoaded) {
                return CoursesList(matieres: state.matieres);
              } else if (state is MatieresError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
          SizedBox(height: 20.h),
          CustomRowTitle(title: "Top Professors", onViewAll: () {}),
          SizedBox(height: 20.h),
          BlocBuilder<ProfessorsBloc, ProfessorsStates>(
              builder: (context, state) {
            if (state is LoadingProfessors) {
              return const Center(
                child: FadingCircleLoadingIndicator(),
              );
            } else if (state is ProfessorsLoaded) {
              return ProfessorList(
                professors: state.professors,
                onItemTap: (index) {
                  debugPrint('Tapped on ${state.professors[index]}');
                },
              );
            }
            return const SizedBox.shrink();
          }),
          SizedBox(height: 90.h),
        ],
      ),
    );
  }
}
