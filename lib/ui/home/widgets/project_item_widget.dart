import 'package:flutter/material.dart';

import '../../../data/model/model.dart';
import '../../../data/model/project/photo_voltaic_system.dart';
import '../../../utils/utils.dart';
import '../../../theme/text_styles.dart';

class ProjectItemWidget extends StatefulWidget {
  final Project project;
  final Size size;
  final Function(Project) onProjectClicked;

  const ProjectItemWidget({
    super.key,
    required this.project,
    required this.size,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(
                  Icons.solar_power,
                  color: Colors.yellow,
                  size: 60.0,
                ),
              ),
              const SizedBox(height: 20),
              Text(widget.project.name, style: pageSubtitleStyle(widget.size)),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Created at:', style: pageSubtitleStyle(widget.size)),
                  const SizedBox(width: 8),
                  Text(
                    parsedDateToPrettyString,
                    style: pageContentStyle(widget.size),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Status:', style: pageSubtitleStyle(widget.size)),
                  const SizedBox(width: 8),
                  Text(
                    status.toUpperCase(),
                    style: pageSubtitleStyle(
                      widget.size,
                    ).copyWith(color: statusColor),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('PVS List:', style: pageSubtitleStyle(widget.size)),
                  const SizedBox(width: 8),
                  Text(
                    _pvsListText(widget.project.systems),
                    style: pageSubtitleStyle(
                      widget.size,
                    ).copyWith(color: statusColor),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
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
