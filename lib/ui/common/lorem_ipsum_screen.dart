import 'package:flutter/material.dart';
import 'package:web_demo/theme/text_styles.dart';

class LoremIpsumScreen extends StatelessWidget {
  final String title;

  const LoremIpsumScreen({super.key, required this.title});

  // TODO: handle the toolbar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            style: WebTextStyles.bodyMediumRegular,
          ),
        ),
      ),
    );
  }
}
