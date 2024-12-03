import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/models/matiere.dart';

import '../../../../../core/routes/route_names.dart';

class CoursesList extends StatefulWidget {
  final List<Matiere> courses;

  const CoursesList({super.key, required this.courses});

  @override
  State<CoursesList> createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: ListView.builder(
        itemCount: widget.courses.length,
        itemBuilder: (context, index) {
          final course = widget.courses[index];
          return GestureDetector(
            onTap: () {
              context.push(
                RoutesNames.etudiantCourseDetails,
                extra: course,
              );
            },
            child: Container(
              width: double.infinity,
              height: 140.h,
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
                      width: 100.w,
                      height: 140.h,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image,
                        size: 50.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Teacher",
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
                            course.name,
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
                                      color: Colors.yellow, size: 16.sp),
                                  Text(
                                    course.coefficient,
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
                                '${course.part} Part',
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
}
