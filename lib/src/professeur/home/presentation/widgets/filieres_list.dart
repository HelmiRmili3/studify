import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class FilieresList extends StatefulWidget {
  final List<String> filieres;
  final Function(int) onItemTap;

  const FilieresList({
    super.key,
    required this.filieres,
    required this.onItemTap,
  });

  @override
  State<FilieresList> createState() => _ProfessorListState();
}

class _ProfessorListState extends State<FilieresList> {
  bool isLoading = true;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 2), () {
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
        itemCount: widget.filieres.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => widget.onItemTap(index),
            child: Container(
              width: 80.w,
              margin: EdgeInsets.only(right: 10.w),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 70.h,
                    width: 70.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        "assets/images/lisi.png",
                        fit: BoxFit.fill,
                      ),
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
                            widget.filieres[index],
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
