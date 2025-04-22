import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/model.dart';
import '../../../data/repository/repository.dart';
import '../../../data/service/service.dart';
import 'map.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState.empty()) {
    on<MapEventNavigate>(_mapNavigateEventToState);
    on<MapEventGetProjects>(_mapGetDetailsEventToState);
    on<MapEventOpenInfoWindow>(_mapOpenWindowEventToState);
    on<MapEventGetUserLocation>(_onGetUserLocation);
  }

  void _mapNavigateEventToState(
    MapEventNavigate event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(route: event.route));
  }

  void _mapOpenWindowEventToState(
    MapEventOpenInfoWindow event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(displayProject: event.project));
  }

  void _mapGetDetailsEventToState(
    MapEventGetProjects event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    var userId = UserRepository().user?.id;
    if (userId == null) {
      emit(
        state.copyWith(
          isLoading: false,
          isError: true,
          isSuccess: false,
          errorMessage: 'User not found',
        ),
      );
      return;
    }
    final projectsResponse = await ProjectsRepository().getUserProjects(
      userId: userId,
    );
    if (projectsResponse != null && projectsResponse.isSuccess) {
      List<dynamic> responseDataList = projectsResponse.responseData;
      List<Project> projects =
          responseDataList
              .map((projectJson) => Project.fromMap(projectJson))
              .toList();

      projects.sort(
        (project1, project2) =>
            project1.createdAt!.compareTo(project2.createdAt!),
      );
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          isError: false,
          projects: projects,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          isError: true,
          errorMessage: projectsResponse?.errorMessage ?? 'Unknown error',
        ),
      );
    }
  }

  Future<void> _onGetUserLocation(
    MapEventGetUserLocation event,
    Emitter<MapState> emit,
  ) async {
    final userLocation = await LocationService().getUserLocation();
    emit(state.copyWith(userLocation: userLocation));
  }
}
