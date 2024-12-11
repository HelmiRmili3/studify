import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../../core/common/widgets/email_text_filed.dart';
import '../../../../../core/routes/route_names.dart';

import '../widgets/custom_app_logo.dart';
import '../widgets/custom_text_filed.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with WidgetsBindingObserver {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool agreeToTermsAndConditions = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    emailFocusNode.addListener(_scrollToBottomOnFocus);
    passwordFocusNode.addListener(_scrollToBottomOnFocus);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _scrollController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _scrollToBottomOnFocus() {
    if (emailFocusNode.hasFocus || passwordFocusNode.hasFocus) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
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
                          const SizedBox(height: 8),
                          Text(
                            "Getting Started.!",
                            style: currentTheme.textTheme.titleLarge?.copyWith(
                              fontFamily: 'Jost',
                              fontWeight: FontWeight.bold,
                              color: currentTheme.textTheme.bodyLarge!.color,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Create an Account to Continue your Journey",
                            style: currentTheme.textTheme.bodyMedium?.copyWith(
                              fontFamily: 'Mulish',
                              fontSize: 14,
                              color: currentTheme.textTheme.bodyLarge!.color,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                EmailTextField(
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  prefixIcon: Icons.lock_outline,
                                  suffixIcon: Icons.visibility_off_outlined,
                                  hintText: 'Password',
                                  controller: passwordController,
                                  isPassword: true,
                                  focusNode: passwordFocusNode,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    shape: const CircleBorder(),
                                    activeColor: currentTheme.primaryColor,
                                    value: agreeToTermsAndConditions,
                                    checkColor:
                                        currentTheme.scaffoldBackgroundColor,
                                    onChanged: (value) {
                                      setState(() {
                                        agreeToTermsAndConditions =
                                            value ?? false;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Agree to Terms & Conditions",
                                    style: currentTheme.textTheme.bodyMedium
                                        ?.copyWith(
                                      fontFamily: 'Mulish',
                                      fontSize: 13,
                                      color: currentTheme
                                          .textTheme.bodyLarge!.color,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 20),
                          CustomElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();

                                GoRouter.of(context)
                                    .push(RoutesNames.fillYourProfile, extra: {
                                  "email": '${emailController.text}@isimg.tn',
                                  "password": passwordController.text,
                                });
                              }
                            },
                            text: "Sign Up",
                            backgroundColor: currentTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 13,
                                  color:
                                      currentTheme.textTheme.bodyLarge!.color,
                                ),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  context.go(RoutesNames.signin);
                                },
                                child: Text(
                                  "Sign In",
                                  style: currentTheme.textTheme.bodyMedium
                                      ?.copyWith(
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
                ),
              );
            },
          ),
        ));
  }
}
