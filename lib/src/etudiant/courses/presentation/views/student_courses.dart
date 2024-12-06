import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studify/src/etudiant/home/presentation/widgets/categories_list.dart';

import '../../../../../core/routes/route_names.dart';

class StudentCourses extends StatefulWidget {
  const StudentCourses({super.key});

  @override
  State<StudentCourses> createState() => _StudentCoursesState();
}

class _StudentCoursesState extends State<StudentCourses> {
  bool _isLoading = true; // Loading state

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'All',
      'Courses',
      'Travaux dirigé',
      'Travaux pratiques',
    ];

    List<Map<String, dynamic>> courses = [
      {
        "teacher": "John Doe",
        "course": "Flutter Development",
        "price": 100.0,
        "rating": 4.5,
        "students": 150,
      },
      {
        "teacher": "Alice Smith",
        "course": "React Native Bootcamp",
        "price": 120.0,
        "rating": 4.7,
        "students": 200,
      },
      {
        "teacher": "Robert Johnson",
        "course": "Python for Data Science",
        "price": 90.0,
        "rating": 4.8,
        "students": 300,
      },
      {
        "teacher": "Emma Wilson",
        "course": "Web Development with JavaScript",
        "price": 80.0,
        "rating": 4.3,
        "students": 250,
      },
      {
        "teacher": "Chris Brown",
        "course": "Machine Learning Basics",
        "price": 150.0,
        "rating": 4.9,
        "students": 180,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoriesList(categories: categories),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return GestureDetector(
                onTap: () {
                  context.push(
                    RoutesNames.etudiantCourseDetails,
                    extra: course,
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
                          child: Icon(
                            Icons.image,
                            size: 50.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      _isLoading
                          ? Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 100.w,
                                            height: 12.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color:
                                                  Colors.white.withOpacity(.3),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.bookmark_border,
                                            color: Colors.green,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      Container(
                                        width: 150.w,
                                        height: 16.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: Colors.white.withOpacity(.3),
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
                                              SizedBox(width: 5.w),
                                              Container(
                                                width: 30.w,
                                                height: 12.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  color: Colors.white
                                                      .withOpacity(.3),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10.w),
                                          Container(
                                            width: 80.w,
                                            height: 12.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color:
                                                  Colors.white.withOpacity(.3),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          course['teacher'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontFamily: 'Mulish',
                                                fontSize: 12.sp,
                                                color: const Color(0xFFFF6B00),
                                              ),
                                        ),
                                        const Icon(
                                          Icons.bookmark_border,
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      course['course'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontFamily: 'Jost',
                                            fontSize: 16.sp,
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
                                              course['rating'].toString(),
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
                                          '${course['students']} Students',
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
        ),
      ],
    );
  }
}
