import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Widget childWidget;
  const HomeScreen({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return childWidget;
  }
}
