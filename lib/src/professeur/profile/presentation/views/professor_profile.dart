import 'package:flutter/material.dart';

class ProfessorProfile extends StatefulWidget {
  const ProfessorProfile({super.key});

  @override
  State<ProfessorProfile> createState() => _ProfessorProfileState();
}

class _ProfessorProfileState extends State<ProfessorProfile> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This is Profile"),
    );
  }
}
