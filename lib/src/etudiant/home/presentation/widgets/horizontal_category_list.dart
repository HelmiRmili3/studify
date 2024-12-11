import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalCategoryList extends StatelessWidget {
  final List<String> categories;
  final double height;
  final Color borderColor;
  final TextStyle? textStyle;
  final void Function(String category) onCategoryTap;

  const HorizontalCategoryList({
    super.key,
    required this.categories,
    this.height = 30.0,
    this.borderColor = Colors.white,
    this.textStyle,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onCategoryTap(categories[index]),
            child: Container(
              height: height.h,
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: Theme.of(context).splashColor,
                border: Border.all(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: textStyle ??
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontFamily: 'Mulish',
                            fontSize: 13.sp,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
