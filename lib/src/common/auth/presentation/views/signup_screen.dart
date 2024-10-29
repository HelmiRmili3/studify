import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../../core/routes/route_names.dart';

import '../widgets/custom_app_logo.dart';
import '../widgets/custom_text_filed.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool agreeToTermsAndConditions = false;

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
                  Row(
                    children: [
                      Checkbox(
                        shape: const CircleBorder(),
                        activeColor: currentTheme.primaryColor,
                        value: agreeToTermsAndConditions,
                        checkColor: currentTheme.scaffoldBackgroundColor,
                        onChanged: (value) {
                          // print("Checkbox value changed: $value");
                          setState(() {
                            agreeToTermsAndConditions =
                                !agreeToTermsAndConditions;
                          });
                        },
                      ),
                      Text(
                        "Agree to Terms & Conditions",
                        style: currentTheme.textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Mulish',
                          fontSize: 13,
                          color: currentTheme.textTheme.bodyLarge!.color,
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
                  context.push(RoutesNames.fillYourProfile);
                },
                text: "Sign Up",
                backgroundColor: currentTheme.primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                      color: currentTheme.textTheme.bodyLarge!.color,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      context.go(RoutesNames.signin);
                    },
                    child: Text(
                      "Sign In",
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
              // Center(
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //       backgroundColor:
              //           const WidgetStatePropertyAll(Colors.transparent),
              //       shape: WidgetStatePropertyAll(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(
              //             25,
              //           ),
              //           side: BorderSide(
              //               color: currentTheme.textTheme.bodyLarge!.color!,
              //               width: 1),
              //         ),
              //       ),
              //       elevation: const WidgetStatePropertyAll(0),
              //       padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(
              //         horizontal: 130,
              //         vertical: 12,
              //       )),
              //     ),
              //     onPressed: () {
              //       context.read<ThemeBloc>().add(ToggleThemeEvent());
              //     },
              //     child: Text(
              //       'Toggle Theme',
              //       style: TextStyle(
              //         color: currentTheme.textTheme.bodyLarge!.color,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
