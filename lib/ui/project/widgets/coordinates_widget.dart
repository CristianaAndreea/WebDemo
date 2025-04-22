import 'package:flutter/material.dart';

import '../../common/common.dart';

class CoordinatesWidget extends StatelessWidget {
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;

  const CoordinatesWidget({
    super.key,
    required this.latitudeController,
    required this.longitudeController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Stack items vertically for small screens
            return Column(
              children: [
                WebTextFormField(
                  controller: latitudeController,
                  hintText: 'Latitude',
                  prefixIcon: Icon(Icons.pin_drop),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter latitude';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                WebTextFormField(
                  controller: longitudeController,
                  hintText: 'Longitude',
                  prefixIcon: Icon(Icons.pin_drop),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter longitude';
                    }
                    return null;
                  },
                ),
              ],
            );
          } else {
            // Display items in a row for larger screens
            return Row(
              children: [
                Flexible(
                  child: WebTextFormField(
                    controller: latitudeController,
                    hintText: 'Latitude',
                    prefixIcon: Icon(Icons.pin_drop),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter latitude';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20), // Add horizontal spacing
                Flexible(
                  child: WebTextFormField(
                    controller: longitudeController,
                    hintText: 'Longitude',
                    prefixIcon: Icon(Icons.pin_drop),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter longitude';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
