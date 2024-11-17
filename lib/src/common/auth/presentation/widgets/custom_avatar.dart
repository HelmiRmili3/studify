import 'dart:io';

import 'package:flutter/material.dart';

class UserProfileAvatar extends StatefulWidget {
  final String imagepath;

  const UserProfileAvatar({
    super.key,
    required this.imagepath,
  });

  @override
  State<UserProfileAvatar> createState() => _UserProfileAvatarState();
}

class _UserProfileAvatarState extends State<UserProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 60.0,
          backgroundImage: widget.imagepath.isNotEmpty
              ? FileImage(
                  File(widget.imagepath),
                )
              : const AssetImage('assets/images/default_avatar.jpg'),
          backgroundColor: Colors.grey[200],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
