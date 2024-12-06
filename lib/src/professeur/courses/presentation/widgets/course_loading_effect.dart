import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CourseLoadingEffect extends StatefulWidget {
  const CourseLoadingEffect({super.key});

  @override
  State<CourseLoadingEffect> createState() => _CourseLoadingEffectState();
}

class _CourseLoadingEffectState extends State<CourseLoadingEffect> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.white.withOpacity(.3),
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
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.white.withOpacity(.3),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 16.sp),
                                    SizedBox(width: 5.w),
                                    Container(
                                      width: 30.w,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.white.withOpacity(.3),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10.w),
                                Container(
                                  width: 80.w,
                                  height: 12.h,
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
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
