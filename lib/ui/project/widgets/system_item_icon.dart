import 'package:flutter/material.dart';

import '../../../data/model/project/photo_voltaic_system.dart';

class SystemItemIcon extends StatelessWidget {
  final PhotoVoltaicSystem pvs;

  const SystemItemIcon({super.key, required this.pvs});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(Icons.solar_power, size: 60.0, color: Colors.orange),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              color: Colors.white,
              // Background color for better visibility
              shape: BoxShape.circle, // Circular shape
            ),
            child: Icon(_getIconForSystem(pvs), size: 20.0, color: Colors.blue),
          ),
        ),
      ],
    );
  }

  IconData _getIconForSystem(PhotoVoltaicSystem system) {
    switch (system.systemType) {
      case 'On Grid':
        return Icons.electrical_services;
      case 'Off Grid':
        return Icons.battery_charging_full;
      case 'Hybrid':
        return Icons.electric_bolt;
      default:
        return Icons.error;
    }
  }
}
