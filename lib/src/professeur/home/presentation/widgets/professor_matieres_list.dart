import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/core/routes/route_names.dart';
import 'package:studify/models/matiere.dart';

class CoursesList extends StatefulWidget {
  final List<Matiere> matieres;

  const CoursesList({super.key, required this.matieres});

  @override
  State<CoursesList> createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.matieres.length,
        itemBuilder: (context, index) {
          final course = widget.matieres[index];
          return GestureDetector(
            onTap: () {
              context.push(
                RoutesNames.professorMatiereDetailes,
                extra: course.toJson(),
              );
            },
            child: Container(
              width: 280.w,
              height: 240.h,
              margin: EdgeInsets.only(right: 20.w),
              decoration: BoxDecoration(
                color: Theme.of(context).splashColor,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.white),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                    child: Container(
                      height: 134.h,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Image.network(
                        course.coverPhoto!.filepath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              course.filiere,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontFamily: 'Mulish',
                                    fontSize: 12.sp,
                                    color: const Color(0xFFFF6B00),
                                  ),
                            ),
                            CircleAvatar(
                              radius: 16.r,
                              backgroundColor: Colors.green.withOpacity(.5),
                              child: Text(course.type.name.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontFamily: 'Mulish',
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          maxLines: 2,
                          course.name,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontFamily: 'Jost',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 16.sp),
                                Text(
                                  "5.0",
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
                                    fontSize: 14,
                                  ),
                            ),
                          ],
                        ),
                      ],
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
