import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../../core/common/widgets/email_text_filed.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/colors.dart';
import '../../domain/entities/user_login_entity.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_events.dart';
import '../blocs/auth/auth_states.dart';
import '../widgets/custom_app_logo.dart';
import '../widgets/custom_text_filed.dart';
import '../../../../../core/common/widgets/loading_overlay.dart';
import '../../../../../core/common/widgets/top_snack_bar.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with WidgetsBindingObserver {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final view = View.of(context);
    final bottomInset = view.viewInsets.bottom;
    final screenHeight = view.physicalSize.height;

    final keyBoardIsOpened = bottomInset > screenHeight * 0.3;

    if (keyBoardIsOpened) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showLoadingOverlay(context);
          }
          if (state is Authenticated) {
            GoRouter.of(context).go(RoutesNames.app, extra: state.user!.role);
            showTopSnackBar(context, state.succes, Colors.green);
          }
          if (state is AuthenticationFailure) {
            showTopSnackBar(context, state.error, Colors.red);
          }
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
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
                            key: _formKey,
                            child: Column(
                              children: [
                                EmailTextField(controller: emailController),
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
                                checkColor:
                                    currentTheme.scaffoldBackgroundColor,
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                },
                              ),
                              Text(
                                "Remember Me",
                                style:
                                    currentTheme.textTheme.bodyMedium?.copyWith(
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
                                  style: currentTheme.textTheme.bodyMedium
                                      ?.copyWith(
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
                              if (_formKey.currentState!.validate()) {
                                // Close the keyboard
                                FocusScope.of(context).unfocus();

                                // Trigger the login event
                                context.read<AuthBloc>().add(AuthLoggedIn(
                                      UserLoginEntity(
                                        email:
                                            '${emailController.text}@isimg.tn',
                                        password: passwordController.text,
                                      ),
                                    ));
                              }
                            },
                            text: "Sign In",
                            backgroundColor: currentTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0.w, vertical: 8.0.h),
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
                                  style: currentTheme.textTheme.bodyMedium
                                      ?.copyWith(
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
            },
          ),
        ),
      ),
    );
  }
}
