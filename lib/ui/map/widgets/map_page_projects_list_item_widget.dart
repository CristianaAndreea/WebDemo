import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_demo/theme/text_styles.dart';
import '../../../data/model/model.dart';
import '../../../data/model/project/photo_voltaic_system.dart';
import '../../../utils/utils.dart';
import '../bloc/map.dart';

class MapPageProjectsListItemWidget extends StatefulWidget {
  final Size size;
  final Project project;

  const MapPageProjectsListItemWidget({
    super.key,
    required this.size,
    required this.project,
  });

  @override
  State<MapPageProjectsListItemWidget> createState() =>
      _MapPageProjectsListItemWidgetState();
}

class _MapPageProjectsListItemWidgetState
    extends State<MapPageProjectsListItemWidget> {
  late MapBloc _mapBloc;

  @override
  void initState() {
    super.initState();
    _mapBloc = BlocProvider.of<MapBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.project.active == true ? "Active" : "Inactive";
    final statusColor =
        widget.project.active == true ? Colors.green : Colors.grey;
    final parsedDate = DateFormatter.formatDateStringToDate(
        dateString: widget.project.createdAt!);
    final parsedDateToPrettyString = DateFormatter.formatDateToStringDate(
        dateTime: parsedDate, dateFormat: DateFormatter.MMM_dd_hh_mm_a);

    return InkWell(
      onTap: () {
        _mapBloc.add(MapEventOpenInfoWindow(project: widget.project));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.solar_power,
                  color: Colors.yellow,
                  size: 60.0,
                ),
                Expanded(child: Container()),
                Text(
                  widget.project.name,
                  style: WebTextStyles.bodyXLargeSemiBold,
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Created at:',
                  style: pageContentStyle(widget.size),
                ),
                const SizedBox(
                  width: 8,
                ),
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
                Text(
                  'Status:',
                  style: pageContentStyle(widget.size),
                ),
                const SizedBox(width: 8),
                Text(
                  status.toUpperCase(),
                  style: pageContentStyle(widget.size)
                      .copyWith(color: statusColor),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PVS List:',
                  style: pageContentStyle(widget.size),
                ),
                const SizedBox(width: 8),
                Text(
                  _pvsListText(widget.project.systems),
                  style: pageContentStyle(widget.size)
                      .copyWith(color: statusColor),
                ),
              ],
            ),
            const SizedBox(width: 8),
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
