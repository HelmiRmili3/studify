import 'package:flutter/material.dart';

class FadingCircleLoadingIndicator extends StatefulWidget {
  const FadingCircleLoadingIndicator({super.key});

  @override
  FadingCircleLoadingIndicatorState createState() =>
      FadingCircleLoadingIndicatorState();
}

class FadingCircleLoadingIndicatorState
    extends State<FadingCircleLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Duration of one loop
    )..repeat(); // Repeat the animation indefinitely

    // Define the size animation (small to large circle)
    _sizeAnimation = Tween<double>(begin: 20.0, end: 100.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Define the opacity animation (fades out)
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: Container(
            width: _sizeAnimation.value,
            height: _sizeAnimation.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade300.withOpacity(_opacityAnimation.value),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
