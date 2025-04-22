
import 'photo_voltaic_system.dart';
import 'project_coordinates.dart';

class Project {
  final int? id;
  final int? userId;
  final String name;
  final String? createdAt;
  final String? updatedAt;
  final bool? active;
  final List<PhotoVoltaicSystem> systems;
  final ProjectCoordinates coordinates;

  Project({
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.active,
    required this.name,
    required this.systems,
    required this.coordinates,
  });

  factory Project.fromMap(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      coordinates: ProjectCoordinates(
        latitude: json['latitude'],
        longitude: json['longitude'],
      ),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      active: json['active'],
      systems: json['photoVoltaicSystems'] != null
          ? json['photoVoltaicSystems']
              .map<PhotoVoltaicSystem>(
                (e) => PhotoVoltaicSystem.fromMap(e),
              )
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toInsertMap() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['latitude'] = coordinates.latitude;
    data['longitude'] = coordinates.longitude;
    data['photovoltaic_systems'] = systems.map((e) => e.toInsertMap()).toList();
    return data;
  }

  Map<String, dynamic> toUpdateMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['latitude'] = coordinates.latitude;
    data['longitude'] = coordinates.longitude;
    data['active'] = active;
    data['photovoltaic_systems'] = systems.map((e) => e.toUpdateMap()).toList();
    return data;
  }

  Project copyWith({
    int? id,
    bool? active,
  }) {
    return Project(
      id: id ?? this.id,
      userId: userId,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
      active: active ?? this.active,
      systems: systems,
      coordinates: coordinates,
    );
  }
}
