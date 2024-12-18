import 'package:flutter/material.dart';
import 'fading_circle_loading_indicator.dart';

class LoadingOverlay {
  OverlayEntry? _overlayEntry;

  void show(BuildContext context, bool isLoading) {
    if (isLoading) {
      if (_overlayEntry != null) return; // Prevent multiple overlays
      final overlay = Overlay.of(context);
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned.fill(
          child: Material(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: FadingCircleLoadingIndicator(),
            ),
          ),
        ),
      );
      overlay.insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}
