import 'package:flutter/material.dart';

class ProfessorHome extends StatefulWidget {
  const ProfessorHome({super.key});

  @override
  State<ProfessorHome> createState() => _ProfessorHomeState();
}

class _ProfessorHomeState extends State<ProfessorHome> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This is Home"),
    );
  }
}
