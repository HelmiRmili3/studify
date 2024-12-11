import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../../models/card_data.dart';
import '../../../../../core/common/widgets/shimmer_loading_effect.dart';

class ScheduleListCardProfessor extends StatefulWidget {
  final List<CardData>? cards;
  final String imageUrl;

  const ScheduleListCardProfessor({
    super.key,
    required this.cards,
    required this.imageUrl,
  });

  @override
  State<ScheduleListCardProfessor> createState() => _PhotoBackgroundCardState();
}

class _PhotoBackgroundCardState extends State<ScheduleListCardProfessor> {
  late final PageController _pageController;
  bool isLoading = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            isLoading ? const ShimmerLoading() : buildPageView(),
            Positioned(
              bottom: 10.h,
              left: 0.w,
              right: 0.w,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: widget.cards?.length ?? 0,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8.h,
                    dotWidth: 6.w,
                    activeDotColor: Colors.yellow,
                    dotColor: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.cards?.length ?? 0,
      itemBuilder: (context, index) {
        final card = widget.cards![index];
        return GestureDetector(
          onTap: () {
            // print("Tapped on card: ${card.course}");
          },
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.time,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                SizedBox(height: 4.h),
                Text(
                  card.course,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Filiere: ${card.instructor}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white70,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      card.location,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
