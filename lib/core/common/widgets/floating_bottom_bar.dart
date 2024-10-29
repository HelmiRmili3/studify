import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  const FloatingBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(30),
              border: Theme.of(context).brightness == Brightness.dark
                  ? Border.all(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1.0,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: BottomNavigationBar(
              selectedLabelStyle:
                  Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500,
                      ),
              unselectedLabelStyle:
                  Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500,
                      ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: onTap,
              items: items,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
