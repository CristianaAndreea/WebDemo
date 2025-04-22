import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:web_demo/theme/text_styles.dart';

import '../../../routes/routes.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  final bool? checked;
  final ValueChanged<bool> onCheckedChanged;

  const TermsAndConditionsWidget({
    super.key,
    required this.checked,
    required this.onCheckedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: Colors.blueAccent,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Creating an account means you\'re okay with our ',
              style: WebTextStyles.bodyMediumRegular.copyWith(
                color: Colors.grey,
              ),
            ),
            TextSpan(
              text: 'Terms of Services',
              style: WebTextStyles.bodyMediumSemiBold.copyWith(
                color: Colors.blueAccent,
              ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      navKey.currentState?.pushNamed(
                        routeLoremIpsum,
                        arguments: 'Terms of Services',
                      );
                    },
            ),
            TextSpan(
              text: ' and our ',
              style: WebTextStyles.bodyMediumRegular.copyWith(
                color: Colors.grey,
              ),
            ),
            TextSpan(
              text: 'Privacy Policy',
              style: WebTextStyles.bodyMediumSemiBold.copyWith(
                color: Colors.blueAccent,
              ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      navKey.currentState?.pushNamed(
                        routeLoremIpsum,
                        arguments: 'Privacy Policy',
                      );
                    },
            ),
          ],
        ),
      ),
      value: checked,
      onChanged: (newValue) {
        onCheckedChanged(newValue!);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
