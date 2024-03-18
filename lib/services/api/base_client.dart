import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/services/api/api_exceptions.dart';

enum RequestType { get, post, put, delete, patch }

class BaseClient {
  static Future<Map<String, dynamic>> generateHeaders() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    return headers;
  }

  static Future<Map<String, dynamic>> generateHeadersPatch() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'If-Match': '*'
    };
    return headers;
  }

  static Future<Map<String, dynamic>> generateHeadersWithToken(
      String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return headers;
  }

  static final Dio _dio = Dio()
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 120,
      ),
    );

  static Future<dynamic> safeApiCall(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function(int value, int progress)? onReceiveProgress,
    // while sending (uploading) progress
    Function(int total, int progress)? onSendProgress,
    Function? onLoading,
    dynamic data,
  }) async {
    try {
      // 1) indicate loading state
      await onLoading?.call();
      // 2) try to perform http request
      late Response response;
      if (requestType == RequestType.get) {
        response = await _dio.get(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else if (requestType == RequestType.post) {
        response = await _dio.post(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else if (requestType == RequestType.put) {
        response = await _dio.put(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else if (requestType == RequestType.delete) {
        response = await _dio.delete(
          url,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else {
        response = await _dio.patch(
          url,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      }
      // 3) return response (api done successfully)
      return await onSuccess(response);
    } on DioError catch (error) {
      // dio error (api reach the server but not performed successfully
      _handleDioError(error: error, url: url, onError: onError);
    } on SocketException {
      // No internet connection
      _handleSocketException(url: url, onError: onError);
    } on TimeoutException {
      // Api call went out of time
      _handleTimeoutException(url: url, onError: onError);
    } catch (error) {
      // unexpected error for example (parsing json error)
      _handleUnexpectedException(url: url, onError: onError, error: error);
    }
  }

  /// handle unexpected error
  static _handleUnexpectedException({
    Function(ApiException)? onError,
    required String url,
    required Object error,
  }) {
    if (onError != null) {
      onError(ApiException(
        message: error.toString(),
        url: url,
      ));
    } else {
      _handleError(error.toString());
    }
  }

  /// handle timeout exception
  static _handleTimeoutException({
    Function(ApiException)? onError,
    required String url,
  }) {
    if (onError != null) {
      onError(ApiException(
        message: AppStrings.SERVER_NOT_RESPONDING,
        url: url,
      ));
    } else {
      _handleError(AppStrings.SERVER_NOT_RESPONDING);
    }
  }

  /// handle timeout exception
  static _handleSocketException({
    Function(ApiException)? onError,
    required String url,
  }) {
    if (onError != null) {
      onError(ApiException(
        message: AppStrings.NO_INTERNET_CONNECTION,
        url: url,
      ));
    } else {
      _handleError(AppStrings.NO_INTERNET_CONNECTION);
    }
  }

  /// handle Dio error
  static _handleDioError({
    required DioError error,
    Function(ApiException)? onError,
    required String url,
  }) {
    // no internet connection
    if (error.message!.toLowerCase().contains('socket')) {
      if (onError != null) {
        return onError(ApiException(
          message: AppStrings.NO_INTERNET_CONNECTION,
          url: url,
        ));
      } else {
        return _handleError(AppStrings.NO_INTERNET_CONNECTION);
      }
    }

    // check if the error is 500 (server problem)
    if (error.response?.statusCode == 500) {
      var exception = ApiException(
        message: AppStrings.SERVER_ERROR,
        url: url,
        statusCode: 500,
      );

      if (onError != null) {
        return onError(exception);
      } else {
        return handleApiError(exception);
      }
    }

    var exception = ApiException(
        url: url,
        message: error.message!,
        response: error.response,
        statusCode: error.response?.statusCode);
    if (onError != null) {
      return onError(exception);
    } else {
      return handleApiError(exception);
    }
  }

  /// handle error automatically (if user didn't pass onError) method
  /// it will try to show the message from api if there is no message
  /// from api it will show the reason
  static handleApiError(ApiException apiException) {
    String msg = apiException.toString();
    //CustomSnackBar.showCustomErrorToast(message: msg);
  }

  /// handle errors without response (500, out of time, no internet,..etc)
  static _handleError(String msg) {
    //CustomSnackBar.showCustomErrorToast(message: msg);
  }
}
