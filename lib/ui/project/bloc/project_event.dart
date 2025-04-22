import 'package:equatable/equatable.dart';

import '../../../data/model/model.dart';
import '../../../data/model/project/photo_voltaic_system.dart';

enum ProjectEventType {
  loadPVSList,
  updatePVSList,
  save,
  generate,
  delete,
  displayReport
}

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class ProjectEventLoadPVSList extends ProjectEvent {
  final Project? project;

  const ProjectEventLoadPVSList({this.project});
}

class ProjectEventUpdatePVSList extends ProjectEvent {
  final PhotoVoltaicSystem updatedPVS;

  const ProjectEventUpdatePVSList({required this.updatedPVS});
}

class ProjectEventSave extends ProjectEvent {
  final int? id;
  final String projectName;
  final String latitude;
  final String longitude;
  final bool? active;

  const ProjectEventSave({
    this.id,
    required this.projectName,
    required this.latitude,
    required this.longitude,
    this.active,
  });
}

class ProjectEventGenerate extends ProjectEvent {
  final int id;

  const ProjectEventGenerate({required this.id});
}

class ProjectEventDelete extends ProjectEvent {
  final int id;

  const ProjectEventDelete({required this.id});
}
