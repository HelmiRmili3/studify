import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomCourseProfile extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomCourseProfile({super.key});

  @override
  State<CustomCourseProfile> createState() => _CustomCourseProfileState();

  @override
  Size get preferredSize => Size.fromHeight(220.h);
}

class _CustomCourseProfileState extends State<CustomCourseProfile> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );

    return SizedBox(
      child: Container(
        height: 220,
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 60.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    Navigator.of(context).pop();
                  }
                  print('Back button tapped');
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
