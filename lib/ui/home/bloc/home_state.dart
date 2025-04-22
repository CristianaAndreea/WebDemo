import 'package:flutter/material.dart';
import '../../../data/model/model.dart';
import '../../../data/model/project/photo_voltaic_system.dart' show PhotoVoltaicSystem;
import '../../../routes/project_route.dart' show ProjectRoute;
import '../../../routes/routes.dart';

@immutable
class HomeState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String errorMessage;
  final String userName;
  final ProjectRoute projectRoute;
  final List<Project> projects;
  final List<PhotoVoltaicSystem> photoVoltaicSystems;

  const HomeState({
    required this.isSuccess,
    required this.isLoading,
    required this.isError,
    required this.errorMessage,
    required this.userName,
    required this.projectRoute,
    required this.projects,
    required this.photoVoltaicSystems,
  });

  factory HomeState.empty() {
    return HomeState(
      isSuccess: false,
      isLoading: false,
      isError: false,
      errorMessage: '',
      userName: '',
      projectRoute: ProjectRoute(route: routeHome),
      projects: const [],
      photoVoltaicSystems: const [],
    );
  }

  HomeState copyWith({
    bool? isSuccess,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    String? userName,
    ProjectRoute? route,
    List<Project>? projects,
    List<PhotoVoltaicSystem>? photoVoltaicSystems,
  }) {
    return HomeState(
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      userName: userName ?? this.userName,
      projectRoute: route ?? projectRoute,
      projects: projects ?? this.projects,
      photoVoltaicSystems: photoVoltaicSystems ?? this.photoVoltaicSystems,
    );
  }
}
