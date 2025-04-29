import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_demo/data/model/project/photo_voltaic_system.dart';
import 'package:web_demo/ui/project/widgets/project_widgets.dart';

import '../../../theme/text_styles.dart';
import '../bloc/project.dart';

class SystemParametersWidget extends StatefulWidget {
  final PhotoVoltaicSystem system;

  const SystemParametersWidget({super.key, required this.system});

  @override
  State<SystemParametersWidget> createState() => _SystemParametersWidgetState();
}

class _SystemParametersWidgetState extends State<SystemParametersWidget> {
  late ProjectBloc _projectBloc;

  @override
  void initState() {
    super.initState();
    _projectBloc = BlocProvider.of<ProjectBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Text(
          '${widget.system.systemDescription} Parameters',
          style: WebTextStyles.bodyXLargeSemiBold,
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            children: [
              Flexible(
                child: SystemAreaInputWidget(
                  area: widget.system.area,
                  onTapOutside: (tiltValue) {
                    final updatedSystem = widget.system.copyWith(
                      tiltAngle: tiltValue,
                    );
                    final event = ProjectEventUpdatePVSList(
                      updatedPVS: updatedSystem,
                    );
                    _projectBloc.add(event);
                  },
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: SystemPowerPeakInputWidget(
                  powerPeak: widget.system.powerPeak,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            children: [
              Flexible(
                child: SystemOrientationInputWidget(
                  orientation: widget.system.orientation,
                  onTapOutside: (orientation) {
                    final updatedSystem = widget.system.copyWith(
                      orientation: orientation,
                    );
                    final event = ProjectEventUpdatePVSList(
                      updatedPVS: updatedSystem,
                    );
                    _projectBloc.add(event);
                  },
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: SystemTiltInputWidget(
                  tiltAngle: widget.system.tiltAngle,
                  onTapOutside: (tiltValue) {
                    final updatedSystem = widget.system.copyWith(
                      tiltAngle: tiltValue,
                    );
                    final event = ProjectEventUpdatePVSList(
                      updatedPVS: updatedSystem,
                    );
                    _projectBloc.add(event);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
