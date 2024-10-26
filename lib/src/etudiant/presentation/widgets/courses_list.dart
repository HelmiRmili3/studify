import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CoursesList extends StatefulWidget {
  final List<Map<String, dynamic>> courses;

  const CoursesList({super.key, required this.courses});

  @override
  State<CoursesList> createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.courses.length,
        itemBuilder: (context, index) {
          final course = widget.courses[index];

          return GestureDetector(
            onTap: () {},
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
                      child: Icon(
                        Icons.image,
                        size: 50.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  isLoading
                      ? const ShimmerCard()
                      : Padding(
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
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Text(
                                    "\$${course['price'].toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Mulish',
                                          fontSize: 15.sp,
                                        ),
                                  ),
                                  VerticalDivider(
                                    thickness: 1,
                                    width: 20.w,
                                    color: Colors.black,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 16.sp),
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
                                  VerticalDivider(
                                    thickness: 1,
                                    width: 20.w,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    '${course['students'].toString()} Students',
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

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white.withOpacity(.3),
                  ),
                ),
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white.withOpacity(.3),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Container(
              width: 150.w,
              height: 15.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white.withOpacity(.3),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(
                  width: 60.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white.withOpacity(.3),
                  ),
                ),
                SizedBox(width: 10.w),
                VerticalDivider(
                  thickness: 1,
                  width: 20.w,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Container(
                      width: 16.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white.withOpacity(.3),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      width: 40.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white.withOpacity(.3),
                      ),
                    ),
                  ],
                ),
                VerticalDivider(
                  thickness: 1,
                  width: 20.w,
                  color: Colors.grey,
                ),
                Container(
                  width: 80.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white.withOpacity(.3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
