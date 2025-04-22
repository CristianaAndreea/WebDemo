import 'dart:typed_data';
import 'package:universal_io/io.dart';
import 'package:web_demo/data/service/service.dart';

import '../../utils/utils.dart';
import '../model/model.dart';

class WebProjectsRepository extends WebService {
  //region Singleton
  static final WebProjectsRepository _singleton =
      WebProjectsRepository._internal();

  factory WebProjectsRepository() {
    return _singleton;
  }

  WebProjectsRepository._internal() : super(baseURL: Constants.baseUrl);

//endregion

  Future<WebResponse> getProjects({
    required num id,
  }) async {
    final response = await getRequest(
      includeToken: true,
      path: '/api/projects',
    );

    final parsedResponse = WebResponse.fromResponse(response);

    return parsedResponse;
  }

  Future<WebResponse> addProject({required Project project}) async {
    final response = await postRequest(
      includeToken: true,
      path: 'api/projects/add',
      parameters: project.toInsertMap(),
    );

    final parsedResponse = WebResponse.fromResponse(response);

    return parsedResponse;
  }

  Future<WebResponse> updateProject({required Project project}) async {
    final response = await postRequest(
      includeToken: true,
      path: 'api/projects/details',
      parameters: project.toUpdateMap(),
    );

    final parsedResponse = WebResponse.fromResponse(response);

    return parsedResponse;
  }

  Future<WebResponse> deleteProject({required int id}) async {
    final response = await deleteRequest(
      includeToken: true,
      path: '/api/projects/delete/$id',
    );

    final parsedResponse = WebResponse.fromResponse(response);

    return parsedResponse;
  }

  // Future<File?> generateProjectReport({required int id}) async {
  Future<Uint8List?> generateProjectReport({required int id}) async {
    final response = await getPdfRequest(
      includeToken: true,
      path: '/api/projects/export-to-pdf/$id',
    );
    if(response != null) {
      try {
        // return File.fromRawPath(response.bodyBytes);
        return response.bodyBytes;
        // print(file.path);
      } catch (e) {
        print(e);
        return null;
      }
    }
    return null;
  }
}
