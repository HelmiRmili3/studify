import 'package:flutter/material.dart';
import 'package:studify/core/common/screens/connectivity_rapper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? action;
  const CustomAppBar({
    super.key,
    required this.title,
    this.action,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return ConnectivityWrapper(
      child: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: showBackButton,
        actions: action,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Jost',
            fontSize: 21,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
