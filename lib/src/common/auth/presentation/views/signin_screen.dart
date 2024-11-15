import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/enums.dart';
import '../widgets/custom_app_logo.dart';
import '../widgets/custom_text_filed.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  UserRole? parseUserRole(String roleString) {
    switch (roleString) {
      case 'student':
        return UserRole.student;
      case 'professor':
        return UserRole.professor;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.admin;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [AppLogo()],
              ),
              Text(
                "Let's Sign In.!",
                style: currentTheme.textTheme.titleLarge?.copyWith(
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.bold,
                  color: currentTheme.textTheme.bodyLarge!.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Login to Your Account to Continue your Journey",
                style: currentTheme.textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Mulish',
                  fontSize: 14,
                  color: AppColors.lightBlack,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                child: Column(
                  children: [
                    CustomTextField(
                      prefixIcon: Icons.email_outlined,
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: Icons.visibility_off_outlined,
                      hintText: 'Password',
                      controller: passwordController,
                      isPassword: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    activeColor: currentTheme.primaryColor,
                    checkColor: currentTheme.scaffoldBackgroundColor,
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                  ),
                  Text(
                    "Remember Me",
                    style: currentTheme.textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Mulish',
                      fontSize: 13,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.push(RoutesNames.forgotPassword);
                    },
                    child: Text(
                      "Forgot Password?",
                      style: currentTheme.textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Mulish',
                        fontSize: 13,
                        color: AppColors.lightBlack,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () {
                  UserRole? role = parseUserRole(emailController.text);
                  context.push(RoutesNames.app,
                      extra: role ?? UserRole.student);
                },
                text: "Sign In",
                backgroundColor: currentTheme.primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 13,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      context.go(RoutesNames.signup);
                    },
                    child: Text(
                      "Sign Up",
                      style: currentTheme.textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Mulish',
                        fontSize: 13,
                        color: currentTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
