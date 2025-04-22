import 'package:flutter/material.dart';
import 'package:web_demo/routes/project_route.dart';
import 'package:web_demo/routes/routes.dart';

@immutable
class MainState {
  final ProjectRoute projectRoute;
  final int currentTabIndex;

  const MainState({
    required this.projectRoute,
    required this.currentTabIndex,
  });

  factory MainState.empty() {
    return MainState(
      projectRoute: ProjectRoute(route: routeHome),
      currentTabIndex: 0,
    );
  }

  MainState copyWith({
    ProjectRoute? route,
    int? currentTabIndex,
  }) {
    return MainState(
      projectRoute: route ?? projectRoute,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }
}
