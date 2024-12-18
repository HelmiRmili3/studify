import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';
import 'package:studify/core/utils/helpers.dart';
import 'package:studify/models/matiere.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/utils/enums.dart';
import '../../../home/presentation/blocs/home/home_bloc.dart';
import '../../../home/presentation/blocs/home/home_events.dart';
import '../../../home/presentation/blocs/home/home_states.dart';
import '../widgets/course_loading_effect.dart';
import '../widgets/professor_categories_list.dart';

class ProfessorCourses extends StatefulWidget {
  final String? category;
  const ProfessorCourses({
    super.key,
    this.category,
  });

  @override
  State<ProfessorCourses> createState() => _ProfessorCoursesState();
}

class _ProfessorCoursesState extends State<ProfessorCourses> {
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category ?? 'All';

    context.read<HomeBloc>().add(LoadMatieres());
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'All',
      'Courses',
      'Travaux dirigé',
      'Travaux pratiques',
    ];

    return Scaffold(
        appBar: const CustomAppBar(title: 'Courses'),
        body: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfessorCategoriesList(
                categories: categories,
                selectedCategory: selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<HomeBloc, HomeStates>(
                builder: (context, state) {
                  if (state is MatieresLoading) {
                    return const CourseLoadingEffect();
                  }
                  if (state is MatieresError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is MatieresLoaded) {
                    var filteredMatieres = state.matieres;
                    if (selectedCategory != 'All') {
                      filteredMatieres = filteredMatieres.where((matiere) {
                        switch (selectedCategory) {
                          case 'Courses':
                            return matiere.type == MatiereType.co;
                          case 'Travaux dirigé':
                            return matiere.type == MatiereType.td;
                          case 'Travaux pratiques':
                            return matiere.type == MatiereType.tp;
                          default:
                            return true;
                        }
                      }).toList();
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: filteredMatieres.length,
                        itemBuilder: (context, index) {
                          Matiere matiere = filteredMatieres[index];
                          return GestureDetector(
                            onTap: () {
                              context.push(
                                RoutesNames.professorMatiereDetailes,
                                extra: matiere.toJson(),
                              );
                            },
                            child: Container(
                              height: 130.h,
                              margin: EdgeInsets.only(bottom: 10.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context).splashColor,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.r),
                                    ),
                                    child: Container(
                                      height: 134.h,
                                      width: 100.w,
                                      color: Colors.grey[300],
                                      child: Image.network(
                                        matiere.coverPhoto!.filepath,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                matiere.filiere,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                      fontFamily: 'Mulish',
                                                      fontSize: 12.sp,
                                                      color: const Color(
                                                          0xFFFF6B00),
                                                    ),
                                              ),
                                              CircleAvatar(
                                                radius: 16.r,
                                                backgroundColor:
                                                    const Color(0xFFFF6B00)
                                                        .withOpacity(.5),
                                                child: Text(
                                                  matiere.type.name
                                                      .toUpperCase(),
                                                  textAlign: TextAlign.left,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                        fontFamily: 'Mulish',
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            matiere.name.capitalizeFirst(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  fontFamily: 'Jost',
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      color: Colors.yellow,
                                                      size: 16.sp),
                                                  Text(
                                                    '4.5',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          fontFamily: 'Mulish',
                                                          fontSize: 11.sp,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 5.w),
                                              Container(
                                                width: 2,
                                                height: 16.h,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                '30 Students',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      fontFamily: 'Mulish',
                                                      fontSize: 14.sp,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ));
  }
}
