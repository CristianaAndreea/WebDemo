import 'package:bloc/bloc.dart';
import '../../../data/model/model.dart';
import '../../../data/repository/repository.dart';
import 'home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.empty()) {
    on<HomeEventGetDetails>(_mapGetDetailsEventToState);
    on<HomeEventNavigate>(_mapNavigateEventToState);
    on<HomeEventFilter>(_mapFilterEventToState);
  }

  void _mapGetDetailsEventToState(
    HomeEventGetDetails event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final userProfileResponse = await UserRepository().getUserProfile();

    if (userProfileResponse != null && userProfileResponse.isSuccess) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          isError: false,
          userName: userProfileResponse.responseData['name'],
        ),
      );
      var userId = userProfileResponse.responseData['id'];
      final projectsResponse = await ProjectsRepository().getUserProjects(
        userId: userId,
      );
      if (projectsResponse != null && projectsResponse.isSuccess) {
        List<dynamic> responseDataList = projectsResponse.responseData;
        List<Project> projects =
            responseDataList
                .map((projectJson) => Project.fromMap(projectJson))
                .toList();
        filterActive(projects);
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
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          isError: true,
          errorMessage: userProfileResponse?.errorMessage ?? 'Unknown error',
        ),
      );
    }
  }

  void _mapNavigateEventToState(
    HomeEventNavigate event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(route: event.route));
  }

  void _mapFilterEventToState(
    HomeEventFilter event,
    Emitter<HomeState> emit,
  ) async {
    switch (event.filterType) {
      case "Oldest":
        state.projects.sort(
          (project1, project2) =>
              project1.createdAt!.compareTo(project2.createdAt!),
        );
        break;
      case "Active":
        state.projects.sort(
          (project1, project2) =>
              (project1.active == project2.active
                  ? 0
                  : (project1.active == false ? 1 : -1)),
        );
        break;
    }

    emit(state.copyWith(projects: state.projects));
  }

  void filterActive(List<Project> projects) {
    projects.sort(
      (project1, project2) =>
          (project1.active == project2.active
              ? 0
              : (project1.active == false ? 1 : -1)),
    );
  }
}
