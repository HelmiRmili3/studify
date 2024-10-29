import 'package:flutter/material.dart';
import 'package:studify/core/common/widgets/custom_app_bar.dart';
import 'package:studify/src/common/auth/presentation/widgets/custom_text_filed.dart';

import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../widgets/custom_avatar.dart';

class FillYourProfileScreen extends StatefulWidget {
  const FillYourProfileScreen({super.key});

  @override
  State<FillYourProfileScreen> createState() => _FillYourProfileScreenState();
}

class _FillYourProfileScreenState extends State<FillYourProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Fill Your Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserProfileAvatar(),
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
              CustomTextField(
                prefixIcon: Icons.email_outlined,
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 20.0),
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
                text: "Continue",
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