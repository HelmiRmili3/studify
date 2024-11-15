import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../../core/routes/route_names.dart';
import '../blocs/onboarding/onboarding_bloc.dart';
import '../blocs/onboarding/onboarding_event.dart';
import '../blocs/onboarding/onboarding_state.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final Map<int, dynamic> pages = {
    0: {
      "image": "assets/images/onboarding1.png",
      "title": "Welcome to the app!",
    },
    1: {
      "image": "assets/images/onboarding2.png",
      "title": "Discover new features.",
    },
    2: {
      "image": "assets/images/onboarding2.png",
      "title": "Get started now!",
    }
  };
  // final List<String> pages = [
  //   "Welcome to the app!",
  //   "Discover new features.",
  //   "Get started now!"
  // ];

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);

    return BlocProvider(
      create: (context) => OnboardingBloc(pages.length),
      child: Scaffold(
        backgroundColor: currentTheme.scaffoldBackgroundColor,
        body: Stack(
          children: [
            BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                return PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    context.read<OnboardingBloc>().add(OnNextPage(index));
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return OnboardingPage(
                      page: pages[index],
                    );
                  },
                );
              },
            ),
            Positioned(
              top: 40.h,
              right: 20.w,
              child: TextButton(
                onPressed: () {
                  context.go(RoutesNames.signin);
                },
                child: Text(
                  "Skip",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Jost',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ),
            Positioned(
              bottom: 30.h,
              left: 20.w,
              right: 20.w,
              child: BlocBuilder<OnboardingBloc, OnboardingState>(
                builder: (context, state) {
                  if (state is OnboardingInitial) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: pages.length,
                          effect: ExpandingDotsEffect(
                            dotHeight: 8.h,
                            dotWidth: 8.w,
                            activeDotColor: currentTheme.primaryColor,
                            dotColor: currentTheme.primaryColor.withOpacity(.2),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        CustomElevatedButton(
                          onPressed: () {
                            if (state.currentPage < pages.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              context
                                  .read<OnboardingBloc>()
                                  .add(OnCompleteOnboarding());
                              context.go(RoutesNames.signin);
                            }
                          },
                          text: state.currentPage == pages.length - 1
                              ? "Get Started"
                              : null,
                          backgroundColor: currentTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
