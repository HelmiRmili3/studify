import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 250.0.h,
          width: 200.0.w,
          child: Image.asset(
            'assets/images/all_logo_bleu_black.png',
            width: 200.0.w,
            height: 200.0.h,
            opacity: const AlwaysStoppedAnimation(0.8),
          ),
        ),
      ],
    );
  }
}
