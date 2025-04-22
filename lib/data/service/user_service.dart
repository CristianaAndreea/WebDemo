import 'package:web_demo/data/service/service.dart';
import '../../utils/utils.dart';
import '../model/model.dart';

class UserService extends WebService {
  //region Singleton
  static final UserService _singleton = UserService._internal();

  factory UserService() {
    return _singleton;
  }

  UserService._internal() : super(baseURL: Constants.baseUrl);

//endregion

  Future<WebResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final params = {
      "name": name,
      "email": email,
      "password": password,
    };

    final response = await postRequest(
      includeToken: false,
      path: '/api/user/register',
      parameters: params,
    );

    final parsedResponse = WebResponse.fromResponse(response);

    return parsedResponse;
  }

  Future<WebResponse> login({
    required String email,
    required String password,
  }) async {
    final params = {
      'email': email,
      'password': password,
    };

    final response = await postRequest(
      includeToken: false,
      path: '/api/user/login',
      parameters: params,
    );

    final parsedResponse = WebResponse.fromResponse(response);

    return parsedResponse;
  }

  Future<WebResponse> logout() async {
    final response = await postRequest(
      includeToken: true,
      path: '/api/user/logout',
    );

    final parsedResponse = WebResponse.fromResponse(response);

    return parsedResponse;
  }

  Future<WebResponse> getUserProfile({
    required num id,
  }) async {
    final response = await getRequest(
      includeToken: false,
      path: '/api/user/details/$id',
    );

    final parsedResponse = WebResponse.fromResponse(response);

    return parsedResponse;
  }

  Future<WebResponse> saveUserProfile({
    required int id,
    required String userName,
    required String email,
    required String password,
  }) async {
    final params = {
      'id': id,
      'email': email,
      'name': userName,
      'password': password,
    };

    final response = await postRequest(
      includeToken: true,
      path: '/api/user/details',
      parameters: params,
    );

    final parsedResponse = WebResponse.fromResponse(response);

    return parsedResponse;
  }

  Future<WebResponse> deleteUserProfile({
    required int id,
  }) async {
    final response = await deleteRequest(
      includeToken: true,
      path: '/api/user/details/$id',
    );

    final parsedResponse = WebResponse.fromResponse(response);

    return parsedResponse;
  }

  // Future<WebResponse> getUserProjects({
  //   required num id,
  // }) async {
  //   final response = await getRequest(
  //     includeToken: true,
  //     path: '/api/user/details/$id',
  //   );
  //
  //   final parsedResponse = WebResponse.fromResponse(response);
  //
  //   return parsedResponse;
  // }
}
