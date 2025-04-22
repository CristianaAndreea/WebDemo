import 'package:flutter/material.dart';

class MapPageWidget extends StatelessWidget {
  final Widget childWidget;

  const MapPageWidget({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return childWidget;
  }
}
