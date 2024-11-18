import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:studify/src/common/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:studify/src/common/auth/presentation/blocs/auth/auth_states.dart';

import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../../core/common/widgets/email_text_filed.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/enums.dart';
import '../../domain/entities/user_login_entity.dart';
import '../blocs/auth/auth_events.dart';
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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            GoRouter.of(context).go(RoutesNames.app, extra: UserRole.student);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0.w),
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
                SizedBox(height: 8.h),
                Text(
                  "Login to Your Account to Continue your Journey",
                  style: currentTheme.textTheme.bodyMedium?.copyWith(
                    fontFamily: 'Mulish',
                    fontSize: 14.sp,
                    color: AppColors.lightBlack,
                  ),
                ),
                SizedBox(height: 30.h),
                Form(
                  child: Column(
                    children: [
                      EmailTextField(
                        controller: emailController,
                      ),
                      SizedBox(height: 20.h),
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
                SizedBox(height: 20.h),
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
                          fontSize: 13.sp,
                          color: AppColors.lightBlack,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLoggedIn(
                          UserLoginEntity(
                            email: '${emailController.text.trim()}@isimg.tn',
                            password: passwordController.text.trim(),
                          ),
                        ));
                  },
                  text: "Sign In",
                  backgroundColor: currentTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 13.sp,
                        color: AppColors.lightBlack,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      onTap: () {
                        context.go(RoutesNames.signup);
                      },
                      child: Text(
                        "Sign Up",
                        style: currentTheme.textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Mulish',
                          fontSize: 13.sp,
                          color: currentTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
