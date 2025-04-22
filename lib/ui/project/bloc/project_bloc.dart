import 'package:bloc/bloc.dart';
import 'package:web_demo/ui/project/bloc/project.dart';

import '../../../data/model/model.dart';
import '../../../data/model/project/photo_voltaic_system.dart';
import '../../../data/model/project/project_coordinates.dart';
import '../../../data/repository/repository.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectState.empty()) {
    on<ProjectEventLoadPVSList>(_mapLoadPVSListToState);
    on<ProjectEventUpdatePVSList>(_mapUpdatePVSListToState);
    on<ProjectEventSave>(_mapSaveProjectEventToState);
    on<ProjectEventDelete>(_mapDeleteProjectEventToState);
    on<ProjectEventGenerate>(_mapGenerateProjectEventToState);
  }

  final List<PhotoVoltaicSystem> photoVoltaicSystems = [
    PhotoVoltaicSystem.offGrid(),
    PhotoVoltaicSystem.onGrid(),
    PhotoVoltaicSystem.hybrid(),
  ];

  void _mapLoadPVSListToState(
    ProjectEventLoadPVSList event,
    Emitter<ProjectState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    var selectedPhotoVoltaicSystems = <PhotoVoltaicSystem>[];
    if (event.project != null) {
      final selectedTypes = event.project!.systems.map((e) => e.systemType);
      for (var element in photoVoltaicSystems) {
        if (selectedTypes.contains(element.systemType)) {
          final system = event.project!.systems
              .firstWhere((e) => e.systemType == element.systemType);
          final updatedSystem = element.copyWith(
            selected: true,
            tiltAngle: system.tiltAngle,
            orientation: system.orientation,
            area: system.area,
            powerPeak: system.powerPeak,
          );
          selectedPhotoVoltaicSystems.add(updatedSystem);
        } else {
          selectedPhotoVoltaicSystems.add(element);
        }
      }
    } else {
      selectedPhotoVoltaicSystems
          .add(photoVoltaicSystems.first.copyWith(selected: true));
      selectedPhotoVoltaicSystems.add(photoVoltaicSystems[1]);
      selectedPhotoVoltaicSystems.add(photoVoltaicSystems[2]);
    }
    emit(state.copyWith(
      pvsList: selectedPhotoVoltaicSystems,
      projectEventType: ProjectEventType.loadPVSList,
    ));
  }

  void _mapUpdatePVSListToState(
    ProjectEventUpdatePVSList event,
    Emitter<ProjectState> emit,
  ) async {
    var selectedPhotoVoltaicSystems = <PhotoVoltaicSystem>[];
    for (var element in state.pvsList) {
      if (element.systemType == event.updatedPVS.systemType) {
        selectedPhotoVoltaicSystems.add(event.updatedPVS);
      } else {
        selectedPhotoVoltaicSystems.add(element);
      }
      emit(state.copyWith(
        pvsList: selectedPhotoVoltaicSystems,
        projectEventType: ProjectEventType.updatePVSList,
      ));
    }
  }

  void _mapSaveProjectEventToState(
    ProjectEventSave event,
    Emitter<ProjectState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final postProject = Project(
      id: event.id,
      name: event.projectName,
      coordinates: ProjectCoordinates(
        latitude: double.parse(event.latitude),
        longitude: double.parse(event.longitude),
      ),
      systems: state.pvsList.where((element) => element.selected).toList(),
    );
    if (event.id == null) {
      // add project
      final addProjectResponse =
          await ProjectsRepository().addProject(project: postProject);
      if (addProjectResponse != null && addProjectResponse.isSuccess) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          isError: false,
          projectEventType: ProjectEventType.save,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          isError: true,
          projectEventType: ProjectEventType.save,
        ));
      }
    } else {
      // update project
      final updateProjectResponse = await ProjectsRepository().updateProject(
        project: postProject.copyWith(
          active: event.active,
        ),
      );
      if (updateProjectResponse != null && updateProjectResponse.isSuccess) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          isError: false,
          projectEventType: ProjectEventType.save,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          isError: true,
          projectEventType: ProjectEventType.save,
        ));
      }
    }
  }

  void _mapDeleteProjectEventToState(
    ProjectEventDelete event,
    Emitter<ProjectState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final deleteProjectResponse =
        await ProjectsRepository().deleteProject(id: event.id);
    if (deleteProjectResponse != null && deleteProjectResponse.isSuccess) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        isError: false,
        projectEventType: ProjectEventType.delete,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        isError: true,
        projectEventType: ProjectEventType.delete,
      ));
    }
  }

  void _mapGenerateProjectEventToState(
    ProjectEventGenerate event,
    Emitter<ProjectState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final generateProjectReportResponse =
        await ProjectsRepository().generateProjectReport(id: event.id);

      emit(state.copyWith(
        isLoading: false,
        isSuccess: generateProjectReportResponse != null,
        isError: generateProjectReportResponse == null,
        bytes: generateProjectReportResponse,
        projectEventType: ProjectEventType.generate,
      ));
  }
}
