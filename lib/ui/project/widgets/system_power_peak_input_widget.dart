import 'package:flutter/material.dart';

class SystemPowerPeakInputWidget extends StatefulWidget  {
  final String? powerPeak;
  const SystemPowerPeakInputWidget({super.key, this.powerPeak});

  @override
  State<SystemPowerPeakInputWidget> createState() => _SystemPowerPeakInputWidgetState();
}

class _SystemPowerPeakInputWidgetState extends State<SystemPowerPeakInputWidget> {
  TextEditingController powerPeakController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final powerPeak = widget.powerPeak ?? '0';
    powerPeakController.text = '$powerPeak kW';
  }

  @override
  void dispose() {
    powerPeakController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: powerPeakController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.show_chart),
        labelText: 'Power peak',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter power peak';
        }
        return null;
      },
    );
  }
}