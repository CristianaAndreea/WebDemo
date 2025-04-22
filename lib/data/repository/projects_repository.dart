import 'dart:typed_data';

import '../model/model.dart';
import '../service/service.dart';

class ProjectsRepository {
  //region Singleton
  static final ProjectsRepository _singleton = ProjectsRepository._internal();

  factory ProjectsRepository() {
    return _singleton;
  }

  ProjectsRepository._internal();

//endregion

  Future<WebResponse?> getUserProjects({required int userId}) async {
    try {
      final response = await WebProjectsRepository().getProjects(id: userId);
      return response;
    } catch (exception, stack) {
      print(exception);
      print(stack);
      return null;
    }
  }

  Future<WebResponse?> addProject({required Project project}) async {
    try {
      final response =
          await WebProjectsRepository().addProject(project: project);
      return response;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<WebResponse?> updateProject({required Project project}) async {
    try {
      final response =
          await WebProjectsRepository().updateProject(project: project);
      return response;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<WebResponse?> deleteProject({required int id}) async {
    try {
      final response = await WebProjectsRepository().deleteProject(id: id);
      return response;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  // Future<File?> generateProjectReport({required int id}) async {
  Future<Uint8List?> generateProjectReport({required int id}) async {
    try {
      final response =
          await WebProjectsRepository().generateProjectReport(id: id);
      return response;
    } catch (exception) {
      print(exception);
      return null;
    }
  }
}
