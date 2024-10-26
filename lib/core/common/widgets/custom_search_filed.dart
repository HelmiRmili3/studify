import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors.dart';

class CustomSearchField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData suffixIcon;
  final VoidCallback? onSuffixIconPress;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const CustomSearchField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    required this.suffixIcon,
    this.onSuffixIconPress,
    required this.controller,
    this.validator,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: AppColors.white,
        width: 2.w,
      ),
    );

    return TextFormField(
      controller: widget.controller,
      obscureText: false, // Adjust this if you need toggling functionality.
      validator: widget.validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).splashColor,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: 'Mulish',
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.lightBlack,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: AppColors.lightBlack,
              )
            : null,
        suffixIcon: IconButton(
          // color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(2),
          icon: Icon(
            widget.suffixIcon,
            size: 29.sp,
          ),
          onPressed: widget.onSuffixIconPress ?? () {},
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 10.w,
        ),
      ),
    );
  }
}
