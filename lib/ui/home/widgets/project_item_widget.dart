import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_demo/ui/project/widgets/project_widgets.dart';

import '../../../data/model/model.dart';
import '../../../data/model/project/photo_voltaic_system.dart';
import '../../../utils/utils.dart';
import '../../../theme/text_styles.dart';
import '../../common/common.dart';

class ProjectItemWidget extends StatefulWidget {
  final Project project;
  final Function(Project) onProjectClicked;

  const ProjectItemWidget({
    super.key,
    required this.project,
    required this.onProjectClicked,
  });

  @override
  State<ProjectItemWidget> createState() => _ProjectItemWidgetState();
}

class _ProjectItemWidgetState extends State<ProjectItemWidget> {
  @override
  Widget build(BuildContext context) {
    final status = widget.project.active == true ? "Active" : "Inactive";
    final statusColor =
        widget.project.active == true ? Colors.green : Colors.grey;
    final parsedDate = DateFormatter.formatDateStringToDate(
      dateString: widget.project.createdAt!,
    );
    final parsedDateToPrettyString = DateFormatter.formatDateToStringDate(
      dateTime: parsedDate,
      dateFormat: DateFormatter.MMM_dd_hh_mm_a,
    );

    return InkWell(
      onTap: () {
        widget.onProjectClicked(widget.project);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: SystemItemIcon(pvs: widget.project.systems.first)),
            const SizedBox(height: 20),
            Text(
              widget.project.name.capitalize!,
              style: WebTextStyles.bodyXLargeSemiBold,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Created at:', style: WebTextStyles.bodyXLargeSemiBold),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    parsedDateToPrettyString,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: WebTextStyles.bodyLargeMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status:', style: WebTextStyles.bodyLargeSemiBold),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    status.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: WebTextStyles.bodyLargeMedium.copyWith(
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('PVS List:', style: WebTextStyles.bodyLargeSemiBold),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _pvsListText(widget.project.systems),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: WebTextStyles.bodyLargeMedium.copyWith(
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String _pvsListText(List<PhotoVoltaicSystem> pvsList) {
    var pvsListText = "";
    for (var pvs in pvsList) {
      pvsListText += "${pvs.systemType}, ";
    }
    // trim the last 2 characters (, )
    final prettyText = pvsListText.substring(0, pvsListText.length - 2);
    return prettyText;
  }
}
