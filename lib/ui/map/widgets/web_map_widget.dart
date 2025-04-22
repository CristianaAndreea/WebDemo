import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/model/model.dart';
import '../../../routes/project_route.dart';
import '../../../routes/routes.dart';
import '../bloc/map.dart';
import 'map_widgets.dart';

MapWidget getMapWidget() => const WebMap();

class WebMap extends StatefulWidget implements MapWidget {
  const WebMap({super.key});

  @override
  State<WebMap> createState() => WebMapState();
}

class WebMapState extends State<WebMap> {
  late MapBloc _mapBloc;

  // List<Marker> markers = [];
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _mapBloc =
        BlocProvider.of<MapBloc>(context)
          ..add(const MapEventGetUserLocation())
          ..add(const MapEventGetProjects());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      builder: (BuildContext context, state) {
        final initialPosition = LatLng(
          state.userLocation.latitude,
          state.userLocation.longitude,
        );
        _addLocationMarker(initialPosition);

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialPosition,
            zoom: 2,
          ),
          markers: _markers,
          onMapCreated: (controller) {
            _mapController = controller;
          },
        );
      },
      listener: (BuildContext context, MapState state) {
        _mapBlocListener(context, state);
      },
    );
  }

  void _addLocationMarker(LatLng latLng) {
    _markers.add(
      Marker(
        markerId: const MarkerId('user_location'),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue, // Customize the marker color
        ),
        infoWindow: const InfoWindow(title: 'Your Location'),
      ),
    );
  }

  void _addProjectMarkers(List<Project> projects) {
    for (var project in projects) {
      _markers.add(
        Marker(
          markerId: MarkerId(project.id.toString()),
          position: LatLng(
            project.coordinates.latitude,
            project.coordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: project.name,
            onTap: () => _navigateToProjectDetails(project),
          ),
        ),
      );
    }
  }

  // void _openInfoWindow(Marker marker) {
  // final infoWindow = InfoWindow(InfoWindowOptions()..content = marker.title);
  // infoWindow.open(map, marker);
  // }

  void _moveCamera(LatLng latLng) {
    // final cameraOptions = CameraOptions()
    //   ..zoom = 15.0
    //   ..center = latLng;
    // map?.moveCamera(cameraOptions);
  }

  void _mapBlocListener(BuildContext context, MapState state) {
    final cameraUpdate = CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(
          state.userLocation.latitude,
          state.userLocation.longitude,
        ),
        zoom: 15.0,
      ),
    );
    _mapController.animateCamera(cameraUpdate);
    if (state.projects.isNotEmpty) {
      _addProjectMarkers(state.projects);
    }
    if (state.displayProject != null) {
      // final displayProjectLatLng = LatLng(
      //   state.displayProject!.coordinates.latitude,
      //   state.displayProject!.coordinates.longitude,
      // );
      final displayLatitude = state.displayProject!.coordinates.latitude;
      final displayLongitude = state.displayProject!.coordinates.longitude;
      // for (var marker in markers) {
      //   final isSameLatitude =
      //       marker.position?.toJSON()?.lat == displayLatitude;
      //   final isSameLongitude =
      //       marker.position?.toJSON()?.lng == displayLongitude;
      //   if (isSameLatitude && isSameLongitude) {
      //     _openInfoWindow(marker);
      //     break;
      //   }
      // }
      // _moveCamera(displayProjectLatLng);
    }
  }

  void _navigateToProjectDetails(Project project) {
    final projectRoute = ProjectRoute(
      route: routeProjectDetails,
      configuration: PageConfiguration.edit,
      project: project,
    );
    final navigateEvent = MapEventNavigate(route: projectRoute);
    _mapBloc.add(navigateEvent);
  }
}
