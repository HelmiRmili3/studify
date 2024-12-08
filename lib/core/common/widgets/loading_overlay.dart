import 'package:flutter/material.dart';

import 'fading_circle_loading_indicator.dart';

void showLoadingOverlay(BuildContext context) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned.fill(
      child: Material(
        color: Colors.black.withOpacity(0.5),
        child: const Center(
          child: FadingCircleLoadingIndicator(),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
