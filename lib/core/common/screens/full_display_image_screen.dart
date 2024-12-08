import 'package:flutter/material.dart';

class FullDisplayImageScreen extends StatelessWidget {
  final String image;
  const FullDisplayImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black12,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
