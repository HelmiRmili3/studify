import 'package:flutter/material.dart';
import 'package:studify/src/auth/presentation/widgets/custom_text_filed.dart';

import '../../../../core/common/widgets/custom_elevated_button.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  TextEditingController nexPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Create New Password',
          style: TextStyle(
            fontFamily: 'Jost',
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Create Your New Password",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 19,
                  ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              prefixIcon: Icons.lock_outline,
              suffixIcon: Icons.visibility_off_outlined,
              hintText: 'New Password',
              controller: nexPasswordController,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              prefixIcon: Icons.lock_outline,
              suffixIcon: Icons.visibility_off_outlined,
              hintText: 'Confirm Password',
              controller: confirmPasswordController,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              onPressed: () {},
              text: "Continue",
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            ),
          ],
        ),
      ),
    );
  }
}
