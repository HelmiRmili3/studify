import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/colors.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  final T value;
  final void Function(T?) onChanged;
  final String hintText;
  final IconData prefixIcon;
  final List<T> items;
  final String Function(T) itemLabelBuilder;

  const CustomDropdownButtonFormField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.hintText,
    required this.prefixIcon,
    required this.items,
    required this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).splashColor,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Mulish',
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.lightBlack,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.lightBlack,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 10.w,
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            itemLabelBuilder(item),
            style: TextStyle(
              fontFamily: 'Mulish',
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.lightBlack,
            ),
          ),
        );
      }).toList(),
    );
  }
}
