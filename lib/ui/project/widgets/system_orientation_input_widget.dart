import 'package:flutter/material.dart';

class SystemOrientationInputWidget extends StatefulWidget {
  final String? orientation;
  final Function(String) onTapOutside;

  const SystemOrientationInputWidget({
    super.key,
    this.orientation,
    required this.onTapOutside,
  });

  @override
  State<SystemOrientationInputWidget> createState() =>
      _SystemOrientationInputWidgetState();
}

class _SystemOrientationInputWidgetState
    extends State<SystemOrientationInputWidget> {
  TextEditingController orientationController = TextEditingController();

  /// The recommended orientation for solar installation
  /// can be south or west, depending on your location.
  @override
  void initState() {
    super.initState();
    orientationController.text = widget.orientation ?? 'W';
  }

  @override
  void dispose() {
    orientationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: orientationController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.explore),
        labelText: 'Orientation (N/E/S/W)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter orientation';
        }
        return null;
      },
      onChanged: (value) {
        widget.onTapOutside(orientationController.text);
      },
    );
  }
}
