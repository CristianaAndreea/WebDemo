import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_demo/ui/project/widgets/project_widgets.dart';

import '../../../data/model/project/photo_voltaic_system.dart';
import '../bloc/project.dart';

class PVSWidget extends StatefulWidget {
  final List<PhotoVoltaicSystem> pvsList;

  final SystemGridConfiguration configuration;
  final VoidCallback? onSystemClick;

  const PVSWidget({
    super.key,
    required this.pvsList,
    required this.configuration,
    this.onSystemClick,
  });

  @override
  State<PVSWidget> createState() => _PVSWidgetState();
}

class _PVSWidgetState extends State<PVSWidget> {
  late ProjectBloc _projectBloc;

  @override
  void initState() {
    super.initState();
    _projectBloc = BlocProvider.of<ProjectBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      // First item preselected
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Return SystemGridWidget if there is enough space
            return SizedBox(
              height: 320,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  mainAxisExtent: 320,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.pvsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap:
                        widget.configuration == SystemGridConfiguration.viewOnly
                            ? widget.onSystemClick
                            : null,
                    child: SystemGridItemWidget(
                      configuration: widget.configuration,
                      system: widget.pvsList[index],
                      onSelected: (bool value) {
                        final updatedPVS = widget.pvsList[index].copyWith(
                          selected: value,
                        );
                        final event = ProjectEventUpdatePVSList(
                          updatedPVS: updatedPVS,
                        );
                        _projectBloc.add(event);
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            // Return a ListView if space is limited
            return ListView.builder(
              itemCount: widget.pvsList.length,
              itemBuilder: (context, index) {
                final system = widget.pvsList[index];
                return ListTile(
                  title: Text('system.name'),
                  onTap:
                      () => {
                        widget.configuration == SystemGridConfiguration.viewOnly
                            ? widget.onSystemClick
                            : null,
                      },
                );
              },
            );
          }
        },
      ),
    );
  }
}
