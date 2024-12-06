import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MatieresLoadingEffect extends StatelessWidget {
  const MatieresLoadingEffect({super.key});

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
