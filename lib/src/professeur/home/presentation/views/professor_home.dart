import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studify/src/professeur/home/presentation/blocs/filieres/professor_filieres_bloc.dart';

import '../../../../../core/common/widgets/custom_search_filed.dart';
import '../../../../../models/card_data.dart';
import '../../../../etudiant/home/presentation/widgets/custom_row_title.dart';

import '../blocs/filieres/professor_filieres_events.dart';
import '../blocs/filieres/professor_filieres_states.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_events.dart';
import '../blocs/home/home_states.dart';
import '../widgets/filieres_loading_effect.dart';
import '../widgets/matieres_loading_effect.dart';
import '../widgets/professor_matieres_list.dart';
import '../widgets/schedule_list_card_professor.dart';
import '../widgets/filieres_list.dart';

class ProfessorHome extends StatefulWidget {
  const ProfessorHome({super.key});

  @override
  State<ProfessorHome> createState() => _ProfessorHomeState();
}

class _ProfessorHomeState extends State<ProfessorHome> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadMatieres());
    context.read<ProfessorFilieresBloc>().add(LoadFilieres());
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
          ScheduleListCardProfessor(
            imageUrl: 'assets/images/homebg.png',
            cards: [
              CardData(
                time: '09:55 - 11:25',
                course: 'CI Préparation TOEIC',
                instructor: 'LISI1',
                location: 'LabLangues',
                onTap: () {
                  // print('Card 1 tapped');
                },
              ),
              CardData(
                time: '11:30 - 13:00',
                course: 'Advanced Mathematics',
                instructor: 'LISI1',
                location: 'Room 203',
                onTap: () {
                  debugPrint('Card 2 tapped');
                },
              ),
              CardData(
                time: '13:30 - 15:00',
                course: 'Flutter Development',
                instructor: 'MPSEIOT2',
                location: 'Computer Lab',
                onTap: () {
                  debugPrint('Card 3 tapped');
                },
              ),
            ],
          ),
          SizedBox(height: 20.h),
          CustomRowTitle(title: "Categories", onViewAll: () {}),
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
          CustomRowTitle(title: "Your Courses", onViewAll: () {}),
          SizedBox(height: 20.h),
          BlocBuilder<HomeBloc, HomeStates>(
            builder: (context, state) {
              if (state is MatieresLoading) {
                return const MatieresLoadingEffect();
              }
              if (state is MatieresError) {
                return Center(child: Text(state.message));
              }
              if (state is MatieresLoaded) {
                return CoursesList(matieres: state.matieres);
              }

              return const SizedBox.shrink();
            },
          ),
          SizedBox(height: 20.h),
          CustomRowTitle(
            title: "Filieres",
            onViewAll: () {},
          ),
          SizedBox(height: 20.h),
          BlocBuilder<ProfessorFilieresBloc, ProfessorFilieresStates>(
              builder: (context, state) {
            if (state is FilieresLoading) {
              return const FilieresLoadingEffect();
            }
            if (state is FilieresError) {
              return Center(child: Text(state.message));
            }
            if (state is FilieresLoaded) {
              return FilieresList(
                filieres: state.filieres,
                onItemTap: (index) {
                  debugPrint('Tapped on ${state.filieres[index].filiere}');
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
