import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/colors.dart';

class CustomTextFieldWithAttachements extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPress;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final int? maxLines;
  final bool isPassword;
  final Widget? bottomChild;

  const CustomTextFieldWithAttachements({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPress,
    required this.controller,
    this.focusNode,
    this.keyboardType,
    this.validator,
    this.maxLines,
    this.isPassword = false,
    this.bottomChild,
  });

  @override
  State<CustomTextFieldWithAttachements> createState() =>
      _CustomTextFieldWithAttachementsState();
}

class _CustomTextFieldWithAttachementsState
    extends State<CustomTextFieldWithAttachements> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.transparent),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).splashColor,
        border: Border.all(
          color: Theme.of(context).splashColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword ? _obscureText : false,
            validator: widget.validator,
            maxLines: widget.maxLines ?? 1,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
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
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.lightBlack,
                      ),
                      onPressed: widget.onSuffixIconPress ??
                          () {
                            if (widget.isPassword) {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            }
                          },
                    )
                  : null,
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.h,
                horizontal: 10.w,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: widget.bottomChild ?? Container(),
          )
        ],
      ),
    );
  }
}
