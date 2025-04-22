import 'package:flutter/material.dart';

class PasswordFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String? Function(String?)? validator;

  const PasswordFormFieldWidget({
    super.key,
    required this.controller,
    this.hintText = 'Password',
    required this.obscureText,
    required this.onToggleVisibility,
    required this.validator,
  });

  @override
  _PasswordFormFieldWidgetState createState() =>
      _PasswordFormFieldWidgetState();
}

class _PasswordFormFieldWidgetState extends State<PasswordFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_open),
        suffixIcon: IconButton(
          icon: Icon(
            widget.obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: widget.onToggleVisibility,
        ),
        hintText: widget.hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
      validator: widget.validator,
    );
  }
}
