import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurriculumItem extends StatelessWidget {
  final String title;
  final String time;
  final String index;

  const CurriculumItem({
    super.key,
    required this.title,
    required this.time,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58.h,
      child: Row(
        children: [
          CircleAvatar(
            radius: 23,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: Text(
              index,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Jost',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.length > 22 ? '${title.substring(0, 22)}...' : title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Jost',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Mulish',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w100,
                      ),
                ),
              ],
            ),
          ),
          Icon(Icons.play_circle, color: const Color(0xFFFF6B00), size: 24.sp),
        ],
      ),
    );
  }
}
