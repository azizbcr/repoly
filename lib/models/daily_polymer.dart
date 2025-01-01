import 'package:flutter/material.dart';

class DailyPolymer {
  final String name;
  final String description;
  final List<String> properties;
  final String category;
  final Color color;

  DailyPolymer({
    required this.name,
    required this.description,
    required this.properties,
    required this.category,
    required this.color,
  });
}
