import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      'Traveaux dirigé',
      'Traveaux pratiques',
    ];
    final List<String> professors = [
      'Dr. Smith',
      'Prof. Johnson',
      'Dr. Williams',
      'Prof. Brown',
      'Dr. Jones',
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
                onTap: () {
                  // print('Card 1 tapped');
                },
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
          CustomRowTitle(
            title: "Categories",
            onViewAll: () {
              debugPrint('View All clicked');
            },
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 30.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    debugPrint('${categories[index]} Cliked');
                  },
                  child: Container(
                    height: 30.h,
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontFamily: 'Mulish',
                              fontSize: 13.sp,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
          CustomRowTitle(title: "Popular Courses", onViewAll: () {}),
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
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfessorsLoaded) {
              return ProfessorList(
                professors: state.professors,
                onItemTap: (index) {
                  debugPrint('Tapped on ${professors[index]}');
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
