import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_demo/data/model/project/photo_voltaic_system.dart';
import 'package:web_demo/data/model/project/project_coordinates.dart';
import 'package:web_demo/ui/common/common.dart';
import 'package:web_demo/theme/text_styles.dart';
import 'package:web_demo/ui/project/widgets/project_widgets.dart';
import '../../../data/model/model.dart';
import '../bloc/project.dart';
import '../report/system_report_widget.dart';
import 'system_parameters_widget.dart';

enum SystemGridConfiguration { viewOnly, edit }

class ProjectContentWidget extends StatefulWidget {
  final Size size;
  final Project? project;

  const ProjectContentWidget({super.key, required this.size, this.project});

  @override
  State<ProjectContentWidget> createState() => _ProjectContentWidgetState();
}

class _ProjectContentWidgetState extends State<ProjectContentWidget> {
  late ProjectBloc _projectBloc;
  final _formKey = GlobalKey<FormState>();
  static final double _defaultLatitude = ProjectCoordinates.chemnitz().latitude;
  static final double _defaultLongitude =
      ProjectCoordinates.chemnitz().longitude;

  late TextEditingController projectNameController;
  late TextEditingController latitudeController;
  late TextEditingController longitudeController;

  @override
  void initState() {
    super.initState();
    _projectBloc = BlocProvider.of<ProjectBloc>(context)
      ..add(ProjectEventLoadPVSList(project: widget.project));
    projectNameController = TextEditingController(text: widget.project?.name);
    latitudeController = TextEditingController(
      text:
          widget.project?.coordinates.latitude.toString() ??
          _defaultLatitude.toString(),
    );
    longitudeController = TextEditingController(
      text:
          widget.project?.coordinates.longitude.toString() ??
          _defaultLongitude.toString(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    projectNameController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectBloc, ProjectState>(
      listener: (context, state) {
        _blocListener(state);
      },
      builder: (context, state) {
        return Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// Project details
                  /// Predefined Parameters:
                  /// Power peak, , area (m2),
                  /// orientation(N/E/S/W), inclination/tilt,
                  /// longitude, latitude.
                  const SizedBox(height: 30),
                  Text(
                    "Project details",
                    style: WebTextStyles.bodyXLargeSemiBold,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: WebTextFormField(
                      controller: projectNameController,
                      hintText: 'Project name',
                      prefixIcon: Icon(Icons.edit_note),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter project name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  CoordinatesWidget(
                    latitudeController: latitudeController,
                    longitudeController: longitudeController,
                  ),
                  const SizedBox(height: 30),
                  Text("PVS type", style: WebTextStyles.bodyXLargeSemiBold),
                  const SizedBox(height: 30),
                  PVSWidget(
                    pvsList: state.pvsList,
                    configuration:
                        widget.project == null
                            ? SystemGridConfiguration.edit
                            : SystemGridConfiguration.viewOnly,
                  ),
                  const SizedBox(height: 30),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return _systemParameters(state.pvsList);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: _optionButtons(),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// The ideal angle for a solar panel installation
  /// is close to or equal to the latitude of your home.
  /// This angle is typically between 30 degrees and 45 degrees.
  Widget _systemParameters(List<PhotoVoltaicSystem> pvsList) {
    final selectedPhotovoltaicSystems = pvsList
        .where((element) => element.selected)
        .toList(growable: false);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: selectedPhotovoltaicSystems.length,
      itemBuilder: (BuildContext context, int index) {
        return SystemParametersWidget(
          system: selectedPhotovoltaicSystems[index],
        );
      },
    );
  }

  Widget _optionButtons() {
    if (widget.project == null) {
      return GeneralButtonWidget(
        text: 'Save',
        onPressed: () {
          _onSaveProject();
        },
      );
    } else {
      final activeProject = widget.project!.active!;
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          activeProject
              ? GeneralButtonWidget(
                text: 'Save',
                onPressed: () {
                  _onSaveProject();
                },
              )
              : Container(),
          const SizedBox(width: 30),
          GeneralButtonWidget(
            text: 'Delete',
            onPressed: () {
              _showDeleteProjectDialog();
            },
          ),
          const SizedBox(width: 30),
          activeProject
              ? GeneralButtonWidget(
                text: 'Generate Report',
                onPressed: () {
                  final generateEvent = ProjectEventGenerate(
                    id: widget.project!.id!,
                  );
                  _projectBloc.add(generateEvent);
                },
              )
              : Container(),
        ],
      );
    }
  }

  Future _showDeleteProjectDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(32.0),
          title: const Text("Delete project"),
          content: Text(
            "Are you sure you want to delete ${widget.project!.name}?",
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final deleteEvent = ProjectEventDelete(id: widget.project!.id!);
                _projectBloc.add(deleteEvent);
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onSaveProject() {
    if (_formKey.currentState!.validate()) {
      final projectName = projectNameController.text;
      final latitude = latitudeController.text;
      final longitude = longitudeController.text;

      final saveEvent = ProjectEventSave(
        id: widget.project?.id,
        projectName: projectName,
        latitude: latitude,
        longitude: longitude,
        active: widget.project?.active,
      );
      _projectBloc.add(saveEvent);
      _formKey.currentState?.reset();
    }
  }

  void _blocListener(ProjectState state) {
    switch (state.projectEventType) {
      case ProjectEventType.delete:
        if (state.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.isError) {
          _showSnackBar('Failed to delete project', Colors.red);
        }
        break;
      case ProjectEventType.generate:
        if (state.isSuccess) {
          final snackBar = SnackBar(
            content: const Text('Successfully generated project report'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              textColor: Colors.white,
              label: 'Show report',
              onPressed: () {
                _showReportDialog(context, state.bytes!);
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state.isError) {
          _showSnackBar('Failed to generate project report', Colors.red);
        }
        break;
      case ProjectEventType.save:
        if (state.isSuccess) {
          _showSnackBar('Successfully saved project', Colors.green);
        } else if (state.isError) {
          _showSnackBar('Failed to save project', Colors.red);
        }
        break;
      default:
        break;
    }
  }

  void _showSnackBar(String message, Color color) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _showReportDialog(BuildContext context, Uint8List bytes) async {
    await showGeneralDialog(
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.centerRight,
          child: SystemReportWidget(bytes: bytes),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }
}
