import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:web_demo/utils/constants.dart';

import '../repository/repository.dart';

class WebService {
  final String baseURL;

  const WebService({required this.baseURL}) : assert(baseURL != null);

  Map<String, String> _headers(bool includeToken) {
    final map = <String, String>{};

    map['Accept'] = 'application/json';
    map['Content-Type'] = 'application/json;  charset=UTF-8';

    if (includeToken) {
      map['Authorization'] = 'Bearer ${UserRepository().token!}';
    }

    return map;
  }

  Future<http.Response?> getRequest({
    required String path,
    required bool includeToken,
    Map<String, String>? customHeaders,
    Map<String, String>? parameters,
  }) async {
    try {
      final uri = Uri.http(Constants.baseUrl, path, parameters);

      final results = await http.get(
        uri,
        headers: customHeaders ?? _headers(includeToken),
      );

      return results;
    } catch (exception, stack) {
      print(exception);
      print(stack);

      return null;
    }
  }

  Future<http.Response?> getPdfRequest({
    required String path,
    required bool includeToken,
    Map<String, String>? customHeaders,
    Map<String, String>? parameters,
  }) async {
    try {
      final uri = Uri.http(Constants.baseUrl, path, parameters);

      final results = await http.get(
        uri,
        headers: customHeaders ?? _headers(includeToken),
      );
      return results;
    } catch (exception, stack) {
      print(exception);
      print(stack);

      return null;
    }
  }

  Future<http.Response?> postRequest({
    required String path,
    required bool includeToken,
    Map<String, String>? customHeaders,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final uri = Uri.http(Constants.baseUrl, path);

      final results = await http.post(
        uri,
        headers: customHeaders ?? _headers(includeToken),
        body: json.encode(parameters),
      );

      return results;
    } catch (exception, stack) {
      print(exception);
      print(stack);

      return null;
    }
  }

  Future<http.Response?> deleteRequest({
    required String path,
    required bool includeToken,
    Map<String, String>? customHeaders,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final uri = Uri.http(Constants.baseUrl, path);

      final results = await http.delete(
        uri,
        headers: customHeaders ?? _headers(includeToken),
        body: json.encode(parameters),
      );

      return results;
    } catch (exception, stack) {
      print(exception);
      print(stack);

      return null;
    }
  }
}
