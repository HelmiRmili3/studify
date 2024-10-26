import 'package:flutter/material.dart';

class CardData {
  final String time;
  final String course;
  final String instructor;
  final String location;
  final VoidCallback onTap;

  CardData({
    required this.time,
    required this.course,
    required this.instructor,
    required this.location,
    required this.onTap,
  });
}
