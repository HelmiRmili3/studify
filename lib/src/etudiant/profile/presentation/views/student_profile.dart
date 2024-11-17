import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/core/routes/route_names.dart';

import '../../../../../core/common/widgets/costom_row.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 65.h, bottom: 100.h),
          height: 600.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).splashColor,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: -50.h,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 140.h,
                      height: 140.h,
                      padding: EdgeInsets.all(4.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green,
                          width: 3.w,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 60.h,
                        backgroundColor: Colors.white,
                        backgroundImage: const AssetImage(
                          'assets/images/default_avatar.png',
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5.h,
                      right: 5.w,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 100.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Helmi S. Rmili',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'Jost',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'helmi.rmili@isimg.tn',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'Mulish',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
              Positioned(
                top: 180.h,
                left: 20.w,
                right: 20.w,
                child: Column(
                  children: [
                    CustomRow(
                      icon: EneftyIcons.profile_outline,
                      title: 'Edit Profile',
                      onTap: () {
                        context.push(RoutesNames.etudiantEditProfile);
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomRow(
                      icon: EneftyIcons.empty_wallet_outline,
                      title: 'Schedule',
                      onTap: () {
                        debugPrint('schedule');
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomRow(
                      icon: EneftyIcons.notification_outline,
                      title: 'Notifications',
                      onTap: () {
                        context.push(RoutesNames.notification);
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomRow(
                      icon: EneftyIcons.security_outline,
                      title: 'Security',
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    CustomRow(
                      icon: EneftyIcons.language_circle_outline,
                      title: 'Language',
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    CustomRow(
                      icon: EneftyIcons.eye_outline,
                      title: 'Dark Mode',
                      onTap: () {
                        context.push(RoutesNames.userThemeMode);
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomRow(
                      icon: EneftyIcons.security_outline,
                      title: 'Terms & Conditions',
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    CustomRow(
                      icon: EneftyIcons.security_outline,
                      title: 'Help & Support',
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
