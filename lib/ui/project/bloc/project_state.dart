import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';
import 'package:web_demo/data/model/project/photo_voltaic_system.dart';
import 'package:web_demo/ui/project/bloc/project.dart';

@immutable
class ProjectState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final List<PhotoVoltaicSystem> pvsList;
  final ProjectEventType? projectEventType;
  final File? report;
  final Uint8List? bytes;

  const ProjectState({
    required this.pvsList,
    required this.isLoading,
    required this.isSuccess,
    required this.isError,
    this.projectEventType,
    this.report,
    this.bytes,
  });

  factory ProjectState.empty() {
    return const ProjectState(
      isLoading: false,
      isSuccess: false,
      isError: false,
      pvsList: <PhotoVoltaicSystem>[],
    );
  }

  ProjectState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    List<PhotoVoltaicSystem>? pvsList,
    ProjectEventType? projectEventType,
    File? file,
    Uint8List? bytes,
  }) {
    return ProjectState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      pvsList: pvsList ?? this.pvsList,
      projectEventType: projectEventType ?? this.projectEventType,
      report: file ?? report,
      bytes: bytes ?? this.bytes,
    );
  }
}
