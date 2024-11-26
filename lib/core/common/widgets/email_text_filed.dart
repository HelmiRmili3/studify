import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors.dart';

class EmailTextField extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const EmailTextField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your firstname and lastname';
        }
        // Validate format: firstname.lastname
        if (!RegExp(r'^[a-zA-Z]+\.[a-zA-Z]+$').hasMatch(value)) {
          return 'Invalid format, use firstname.lastname';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).splashColor,
        hintText: "firstname.lastname",
        hintStyle: TextStyle(
          fontFamily: 'Mulish',
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.lightBlack,
        ),
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: AppColors.lightBlack,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 18.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "@isimg.tn",
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
            ],
          ),
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
