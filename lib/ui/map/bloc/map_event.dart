import 'package:equatable/equatable.dart';
import 'package:web_demo/routes/project_route.dart';

import '../../../data/model/model.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapEventGetProjects extends MapEvent {
  const MapEventGetProjects();
}

class MapEventNavigate extends MapEvent {
  final ProjectRoute route;

  const MapEventNavigate({required this.route});

  @override
  List<Object> get props => [route];
}

class MapEventOpenInfoWindow extends MapEvent {
  final Project project;

  const MapEventOpenInfoWindow({required this.project});

  @override
  List<Object> get props => [project];
}

class MapEventGetUserLocation extends MapEvent {
  const MapEventGetUserLocation();
}
