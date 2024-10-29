import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProfessorList extends StatefulWidget {
  final List<String> professors;
  final Function(int) onItemTap;

  const ProfessorList({
    super.key,
    required this.professors,
    required this.onItemTap,
  });

  @override
  State<ProfessorList> createState() => _ProfessorListState();
}

class _ProfessorListState extends State<ProfessorList> {
  bool isLoading = true;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.professors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => widget.onItemTap(index),
            child: Container(
              width: 80.w,
              margin: EdgeInsets.only(right: 10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 70.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.image,
                      size: 30.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  isLoading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.white,
                          child: Container(
                            width: 60.w,
                            height: 14.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ),
                        )
                      : Flexible(
                          child: Text(
                            widget.professors[index],
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 12.sp,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w500,
                                    ),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
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
