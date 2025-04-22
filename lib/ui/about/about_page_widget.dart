import 'package:flutter/material.dart';

class AboutPageWidget extends StatelessWidget {
  const AboutPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          'About Page',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}