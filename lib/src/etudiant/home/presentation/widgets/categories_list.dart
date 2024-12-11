import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesList extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoriesList({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              height: 30.h,
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Theme.of(context).splashColor,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Center(
                child: Text(
                  category,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFamily: 'Mulish',
                        fontSize: 13.sp,
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyLarge!.color,
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
