import 'package:flutter/material.dart';
import 'package:web_demo/theme/text_styles.dart';

class WebTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;
  final String? Function(String?)? validator;

  const WebTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: hintText,
        hintStyle: WebTextStyles.bodyMediumRegular,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
      validator: validator,
    );
  }
}
