import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_demo/routes/project_route.dart';
import 'package:web_demo/routes/routes.dart';

import '../../../data/model/model.dart';

@immutable
class MapState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String errorMessage;
  final ProjectRoute projectRoute;
  final List<Project> projects;
  final Project? displayProject;
  final LatLng userLocation;

  const MapState({
    required this.projectRoute,
    required this.projects,
    required this.isSuccess,
    required this.isLoading,
    required this.isError,
    required this.errorMessage,
    this.userLocation = const LatLng(0, 0),
    this.displayProject,
  });

  factory MapState.empty() {
    return MapState(
      projectRoute: ProjectRoute(route: routeMap),
      projects: const [],
      isSuccess: false,
      isLoading: false,
      isError: false,
      errorMessage: '',
    );
  }

  MapState copyWith({
    ProjectRoute? route,
    List<Project>? projects,
    bool? isSuccess,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    Project? displayProject,
    LatLng? userLocation,
  }) {
    return MapState(
      projectRoute: route ?? projectRoute,
      projects: projects ?? this.projects,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      displayProject: displayProject ?? this.displayProject,
      userLocation: userLocation ?? this.userLocation,
    );
  }
}
