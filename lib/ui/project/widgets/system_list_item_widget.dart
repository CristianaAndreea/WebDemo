import 'package:flutter/material.dart';
import 'package:web_demo/data/model/project/photo_voltaic_system.dart';
import 'package:web_demo/theme/text_styles.dart';
import 'package:web_demo/ui/project/widgets/project_widgets.dart';

class SystemListItemWidget extends StatelessWidget {
  final PhotoVoltaicSystem pvs;
  final Function(bool) onSelected;
  final VoidCallback onExpanded;

  const SystemListItemWidget({
    super.key,
    required this.pvs,
    required this.onSelected,
    required this.onExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: [
          ListTile(
            leading: Checkbox(
              activeColor: Colors.blueAccent,
              value: pvs.selected,
              onChanged: (bool? value) {
                onSelected(value!);
              },
            ),
            title: Row(
              children: [
                SystemItemIcon(pvs: pvs),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    pvs.systemType,
                    style: WebTextStyles.bodyMediumSemiBold,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(pvs.expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: onExpanded,
            ),
          ),
          if (pvs.expanded) ...[
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Brand: ',
                    style: WebTextStyles.bodyMediumBold,
                  ),
                  TextSpan(
                    text: pvs.brandName,
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
                    text: pvs.modelName,
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
                    text: pvs.systemPower,
                    style: WebTextStyles.bodyMediumRegular,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SystemParametersWidget(system: pvs),
            SizedBox(height: 24),
          ] else
            Container(),
        ],
      ),
    );
  }
}
