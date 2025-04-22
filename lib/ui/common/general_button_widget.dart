import 'package:flutter/material.dart';
import 'package:web_demo/theme/text_styles.dart';

class GeneralButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final WidgetStateProperty<Color>? backgroundColor;
  final bool? enabled;

  const GeneralButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    var btnColor =
        backgroundColor != null
            ? enabled != null && enabled!
                ? backgroundColor
                : WidgetStateProperty.all(Colors.grey)
            : enabled != null && enabled!
            ? WidgetStateProperty.all(Colors.blueAccent)
            : WidgetStateProperty.all(Colors.grey);
    return SizedBox(
      width: 200,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: btnColor,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        onPressed: () {
          return enabled != null && enabled! ? onPressed() : null;
        },
        child: Text(
          text,
          style: WebTextStyles.bodyMediumSemiBold.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
