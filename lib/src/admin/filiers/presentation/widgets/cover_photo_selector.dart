import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoverPhotoSelector extends StatefulWidget {
  final String imagePath;

  const CoverPhotoSelector({
    super.key,
    required this.imagePath,
  });

  @override
  State<CoverPhotoSelector> createState() => _CoverPhotoSelectorState();
}

class _CoverPhotoSelectorState extends State<CoverPhotoSelector> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Cover Image Container
        Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(
              image: widget.imagePath.isNotEmpty
                  ? FileImage(File(widget.imagePath))
                  : const AssetImage('assets/images/placeholder.png')
                      as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Edit Button
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
      ],
    );
  }
}
