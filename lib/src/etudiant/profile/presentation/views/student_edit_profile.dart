import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';

import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../common/auth/presentation/widgets/custom_avatar.dart';
import '../../../../common/auth/presentation/widgets/custom_text_filed.dart';

class StudentEditProfile extends StatefulWidget {
  const StudentEditProfile({super.key});

  @override
  State<StudentEditProfile> createState() => _StudentEditProfileState();
}

class _StudentEditProfileState extends State<StudentEditProfile> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      debugPrint('Tapped on avatar');
                    },
                    child: SizedBox(
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
                                color: Colors.blue,
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
                                color: Colors.blue,
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
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                hintText: 'Full Name',
                controller: fullNameController,
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                hintText: 'Nick Name',
                controller: nickNameController,
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                prefixIcon: Icons.calendar_month_outlined,
                hintText: 'Date of Birth',
                controller: dateOfBirthController,
              ),
              const SizedBox(height: 20.0),
              // CustomTextField(
              //   prefixIcon: Icons.email_outlined,
              //   hintText: 'Email',
              //   controller: emailController,
              // ),
              // const SizedBox(height: 20.0),
              CustomTextField(
                prefixIcon: Icons.phone_android_outlined,
                hintText: 'Phone Number',
                controller: phoneNumberController,
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                hintText: 'Gender',
                controller: genderController,
              ),
              const SizedBox(height: 20.0),
              CustomElevatedButton(
                onPressed: () {},
                text: "Update",
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
