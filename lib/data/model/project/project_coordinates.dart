class ProjectCoordinates {
  final double latitude;
  final double longitude;

  ProjectCoordinates({
    required this.latitude,
    required this.longitude,
  });

  factory ProjectCoordinates.chemnitz() {
    return ProjectCoordinates(
      latitude: 50.82683663538185,
      longitude: 12.914310296680199,
    );
  }

  factory ProjectCoordinates.closeToChemnitz() {
    return ProjectCoordinates(
      latitude: 50.82683663538180,
      longitude: 12.914310296680190,
    );
  }
}