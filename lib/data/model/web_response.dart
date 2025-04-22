import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class WebResponse {
  final WebResponseCode code;
  final String? errorMessage;
  final dynamic responseData;

  WebResponse({
    required this.code,
    this.errorMessage,
    this.responseData,
  });

  factory WebResponse.fromMap(Map map) {
    try {
      final errorCode = map['error_code']['code'];
      final errorMessage = map['error_code']['message'];
      final responseData = map['response'];

      return WebResponse(
        code: _parseCode(errorCode),
        errorMessage: errorMessage,
        responseData: responseData,
      );
    } catch (exception) {
      return WebResponse(
        code: WebResponseCode.CouldNotParse,
      );
    }
  }

  factory WebResponse.fromResponse(http.Response? response) {
    try {
      if (response != null) {
        switch (response.statusCode) {
          case 200:
            final map = jsonDecode(response.body);

            return WebResponse(
              code: WebResponseCode.Success,
              responseData: map,
            );
          default:
            final map = jsonDecode(response.body);

            final errorCode = map['status'];
            final errorMessage = map['error'];
            final path = map['path'];
            return WebResponse(
              code: WebResponseCode.GeneralError,
              errorMessage:'$errorCode $errorMessage for path $path',
            );
        }
      } else {
        return WebResponse(
          code: WebResponseCode.GeneralError,
          errorMessage: 'Response is null',
        );
      }
    } catch (exception) {
      return WebResponse(
        code: WebResponseCode.CouldNotParse,
        errorMessage: exception.toString(),
      );
    }
  }

  factory WebResponse.fromPdfResponse(http.Response? response) {
    try {
      if (response != null) {
        switch (response.statusCode) {
          case 200:
            final map = jsonDecode(response.body);

            return WebResponse(
              code: WebResponseCode.Success,
              responseData: map,
            );
          default:
            final map = jsonDecode(response.body);

            final errorCode = map['status'];
            final errorMessage = map['error'];
            final path = map['path'];
            return WebResponse(
              code: WebResponseCode.GeneralError,
              errorMessage:'$errorCode $errorMessage for path $path',
            );
        }
      } else {
        return WebResponse(
          code: WebResponseCode.GeneralError,
          errorMessage: 'Response is null',
        );
      }
    } catch (exception) {
      return WebResponse(
        code: WebResponseCode.CouldNotParse,
        errorMessage: exception.toString(),
      );
    }
  }

  bool get isSuccess {
    return code == WebResponseCode.Success;
  }

  static WebResponseCode _parseCode(int codeString) {
    switch (codeString) {
      case 200:
        return WebResponseCode.Success;
      case 400:
        return WebResponseCode.GeneralError;
        break;
      case 1000:
        return WebResponseCode.UserNotFound;
        break;
      case 1001:
        return WebResponseCode.LoginError;
      case 1003:
        return WebResponseCode.EmailExists;
      case 11004:
        return WebResponseCode.EmailNotFound;
      case 4000:
        return WebResponseCode.InvalidParams;
      case 4001:
        return WebResponseCode.MissingParams;
      default:
        return WebResponseCode.UnknownError;
    }
  }
}

enum WebResponseCode {
  CouldNotParse,
  Success,
  UnknownError,
  GeneralError,
  UserNotFound,
  LoginError,
  EmailExists,
  EmailNotFound,
  InvalidParams,
  MissingParams,
}
