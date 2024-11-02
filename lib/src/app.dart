import 'package:flutter/material.dart';
import 'package:studify/core/utils/enums.dart';

import 'admin/admin.dart';
import 'etudiant/etudiant_screen.dart';
import 'professeur/professeur_screen.dart';

// ignore: must_be_immutable
class App extends StatefulWidget {
  final UserRole role;
  const App({
    super.key,
    required this.role,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    switch (widget.role) {
      case UserRole.student:
        return const EtudiantScreen();
      case UserRole.professor:
        return const ProfessorScreen();
      case UserRole.admin:
        return const Admin();
    }
  }
}
