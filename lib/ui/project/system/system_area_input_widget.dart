import 'package:flutter/material.dart';

class SystemAreaInputWidget extends StatefulWidget {
  final String? area;
  final Function(String) onTapOutside;

  const SystemAreaInputWidget({
    super.key,
    this.area,
    required this.onTapOutside,
  });

  @override
  State<SystemAreaInputWidget> createState() => _SystemAreaInputWidgetState();
}

class _SystemAreaInputWidgetState extends State<SystemAreaInputWidget> {
  TextEditingController areaController = TextEditingController();

  @override
  void initState() {
    // Area calculation: Off grid system : one panel size:
    super.initState();
    areaController.text = widget.area ?? '458';
  }

  @override
  void dispose() {
    areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: areaController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.square_outlined),
        labelText: 'Area (square meters)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter area';
        }
        return null;
      },
      onChanged: (value) {
        widget.onTapOutside(areaController.text);
      },
    );
  }
}
