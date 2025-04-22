import 'package:flutter/material.dart';
import 'package:web_demo/theme/text_styles.dart';

class WebAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  final String? confirmText;
  final VoidCallback? onConfirm;

  final String? cancelText;
  final VoidCallback? onCancel;

  final String? neutralText;
  final VoidCallback? onNeutral;

  const WebAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    this.confirmText,
    this.onConfirm,
    this.cancelText,
    this.onCancel,
    this.neutralText,
    this.onNeutral,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(32.0),
      title: Text(title, style: WebTextStyles.bodyXLargeSemiBold),
      content: Text(content, style: WebTextStyles.bodyMedium),
      actions: <Widget>[
        if (confirmText != null && confirmText!.isNotEmpty)
          TextButton(
            onPressed: onConfirm,
            child: Text(
              confirmText!.toUpperCase(),
              style: WebTextStyles.bodyMediumSemiBold.copyWith(
                color: Colors.blueAccent,
              ),
            ),
          ),
        if (neutralText != null && neutralText!.isNotEmpty)
          TextButton(
            onPressed: onNeutral,
            child: Text(
              neutralText!.toUpperCase(),
              style: WebTextStyles.bodyMediumSemiBold.copyWith(
                color: Colors.blueAccent,
              ),
            ),
          ),

        if (cancelText != null && cancelText!.isNotEmpty)
          TextButton(
            onPressed: onCancel,
            child: Text(
              cancelText!.toUpperCase(),
              style: WebTextStyles.bodyMediumSemiBold.copyWith(
                color: Colors.black,
              ),
            ),
          ),
      ],
    );
  }
}
