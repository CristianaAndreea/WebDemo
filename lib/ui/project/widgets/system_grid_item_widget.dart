import 'package:flutter/material.dart';
import 'package:web_demo/data/model/project/photo_voltaic_system.dart';
import 'package:web_demo/theme/text_styles.dart';
import 'package:web_demo/ui/project/widgets/project_widgets.dart';

import '../../common/common.dart';
import 'project_content_widget.dart';

class SystemGridItemWidget extends StatefulWidget {
  final PhotoVoltaicSystem system;
  final SystemGridConfiguration configuration;
  final Function(bool value) onSelected;

  const SystemGridItemWidget({
    super.key,
    required this.system,
    required this.configuration,
    required this.onSelected,
  });

  @override
  State<SystemGridItemWidget> createState() => _SystemGridItemWidgetState();
}

class _SystemGridItemWidgetState extends State<SystemGridItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: widget.system.selected,
            activeColor: Colors.blueAccent,
            onChanged: (bool? value) {
              widget.onSelected(value!);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: SystemItemIcon(pvs: widget.system)),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'System type: ',
                        style: WebTextStyles.bodyMediumBold,
                      ),
                      TextSpan(
                        text: widget.system.systemDescription,
                        style: WebTextStyles.bodyMediumRegular,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Brand: ',
                        style: WebTextStyles.bodyMediumBold,
                      ),
                      TextSpan(
                        text: widget.system.brandName,
                        style: WebTextStyles.bodyMediumRegular,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Model: ',
                        style: WebTextStyles.bodyMediumBold,
                      ),
                      TextSpan(
                        text: widget.system.modelName,
                        style: WebTextStyles.bodyMediumRegular,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Power: ',
                        style: WebTextStyles.bodyMediumBold,
                      ),
                      TextSpan(
                        text: widget.system.systemPower,
                        style: WebTextStyles.bodyMediumRegular,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
