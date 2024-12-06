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
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 100.h,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor.withOpacity(.1),
        ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    maxLines: 2,
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Jost',
                          fontSize: 15.sp,
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
            Icon(
              Icons.more_outlined,
              color: Colors.green,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
