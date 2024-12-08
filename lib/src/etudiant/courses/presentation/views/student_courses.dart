import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studify/src/etudiant/home/presentation/widgets/categories_list.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../home/presentation/blocs/courses/courses_bloc.dart';
import '../../../home/presentation/blocs/courses/courses_states.dart';

class StudentCourses extends StatefulWidget {
  const StudentCourses({super.key});

  @override
  State<StudentCourses> createState() => _StudentCoursesState();
}

class _StudentCoursesState extends State<StudentCourses> {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'All',
      'Courses',
      'Travaux dirigé',
      'Travaux pratiques',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoriesList(categories: categories),
        const SizedBox(height: 20),
        BlocBuilder<CoursesBloc, CoursesStates>(
          builder: (context, state) {
            if (state is MatieresLoading) {
              return Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          width: double.infinity,
                          height: 130.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is MatieresLoaded) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.matieres.length,
                  itemBuilder: (context, index) {
                    final matiere = state.matieres[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          RoutesNames.etudiantCourseDetails,
                          extra: matiere,
                        );
                      },
                      child: Container(
                        width: double.infinity,
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
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r),
                                bottomLeft: Radius.circular(10.r),
                              ),
                              child: Container(
                                height: 130.h,
                                width: 100.w,
                                color: Colors.grey[300],
                                child: matiere.coverPhoto?.filepath != null
                                    ? Image.network(
                                        matiere.coverPhoto!.filepath!,
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(Icons.image, size: 50.sp),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            matiere.part.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  fontFamily: 'Mulish',
                                                  fontSize: 12.sp,
                                                  color:
                                                      const Color(0xFFFF6B00),
                                                ),
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 16.r,
                                          backgroundColor:
                                              Colors.green.withOpacity(.5),
                                          child: Text(
                                            matiere.type.name.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  fontFamily: 'Mulish',
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      matiere.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontFamily: 'Jost',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.yellow, size: 16.sp),
                                        SizedBox(width: 5.w),
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
                                        SizedBox(width: 10.w),
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
            } else if (state is MatieresError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
