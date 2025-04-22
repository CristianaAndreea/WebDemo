import 'package:flutter/material.dart';
import 'package:web_demo/theme/text_styles.dart';

class WebRichTextWidget extends StatelessWidget {
  final String text;
  final String action;

  const WebRichTextWidget({
    super.key,
    required this.text,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$text ',
        style: WebTextStyles.bodyMediumRegular,
        children: [
          TextSpan(
            text: action,
            style: WebTextStyles.bodyMediumSemiBold.copyWith(
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
