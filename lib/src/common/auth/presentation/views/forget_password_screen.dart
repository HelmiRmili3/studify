import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/core/common/widgets/custom_elevated_button.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/colors.dart';
import '../widgets/reset_option_card.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        title: const Text(
          'Forget Password',
          style: TextStyle(
            fontFamily: 'Jost',
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Select one of the options below to reset your password',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightBlack,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ResetOptionCard(
                icon: Icons.email_outlined,
                title: 'Via Email',
                description: 'helmi.rmili@isimg.tn',
                onPressed: () {
                  // Handle email option press
                  // print('Email option selected');
                },
              ),
              const SizedBox(height: 10),
              ResetOptionCard(
                icon: Icons.phone_outlined,
                title: 'Via Phone',
                description: '+1-234-567-890',
                onPressed: () {
                  // Handle phone option press
                  // print('Phone option selected');
                },
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () {
                  context.push(RoutesNames.resetPassword);
                },
                text: 'Continue',
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
