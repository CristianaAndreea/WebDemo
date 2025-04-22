import 'package:flutter/material.dart';

class SystemTiltInputWidget extends StatefulWidget {
  final String? tiltAngle;
  final Function(String) onTapOutside;

  const SystemTiltInputWidget({
    super.key,
    this.tiltAngle,
    required this.onTapOutside,
  });

  @override
  State<SystemTiltInputWidget> createState() => _SystemTiltInputWidgetState();
}

class _SystemTiltInputWidgetState extends State<SystemTiltInputWidget> {
  TextEditingController tiltController = TextEditingController();

  /// The ideal angle for a solar panel installation
  /// is close to or equal to the latitude of your home.
  /// This angle is typically between 30 degrees and 45 degrees.
  @override
  void initState() {
    super.initState();
    tiltController.text = widget.tiltAngle ?? '30';
  }

  @override
  void dispose() {
    tiltController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tiltController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.rotate_90_degrees_cw_outlined),
        labelText: 'Tilt (degrees)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter tilt';
        }
        return null;
      },
      onChanged: (value) {
        widget.onTapOutside(tiltController.text);
      },
    );
  }
}
