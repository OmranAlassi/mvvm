// import 'package:dio/dio.dart';
// import 'error_model.dart';

// class ServerException implements Exception {
//   final ErrorModel errorModel;
//   ServerException({required this.errorModel});
// }

// void handleDioExceptions(DioException e) {
//   switch (e.type) {
//     case DioExceptionType.connectionTimeout:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.sendTimeout:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.receiveTimeout:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.badCertificate:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.cancel:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.connectionError:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.unknown:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.transformTimeout:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.badResponse:
//       switch (e.response?.statusCode) {
//         case 400:
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 401:
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 403:
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 404:
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 422:
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 429:
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 500:
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 502:
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 504:
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         default:
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//       }
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mvvm/core/const/end_point.dart';

import 'error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException({required this.errorModel});

  @override
  String toString() => errorModel.errorMessage;
}

Never handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw _exception(
        'Connection is too slow or unstable. Please check your internet and try again.',
      );
    case DioExceptionType.sendTimeout:
      throw _exception(
        'Sending data took too long. Please check your internet and try again.',
      );
    case DioExceptionType.receiveTimeout:
      throw _exception(
        'The server is taking too long to respond. Please try again later.',
      );
    case DioExceptionType.transformTimeout:
      throw _exception('Processing the server response took too long.');
    case DioExceptionType.badCertificate:
      throw _exception('Secure connection failed. Please try again later.');
    case DioExceptionType.cancel:
      throw _exception('The request was cancelled.');
    case DioExceptionType.connectionError:
      throw _exception(_noInternetMessage);
    case DioExceptionType.unknown:
      if (e.error is SocketException) {
        throw _exception(_noInternetMessage);
      }
      throw _exception('Something went wrong. Please try again.');
    case DioExceptionType.badResponse:
      throw _fromResponse(e.response);
  }
}

const String _noInternetMessage =
    'No internet connection. Please check your Wi-Fi or mobile data and try again.';

ServerException _fromResponse(Response? response) {
  dynamic data = response?.data;

  if (data is String) {
    try {
      data = jsonDecode(data);
    } catch (_) {}
  }

  if (data is Map<String, dynamic> && data[ApiKey.message] != null) {
    return ServerException(errorModel: ErrorModel.fromJson(data));
  }

  return _exception(_messageForStatus(response?.statusCode));
}

String _messageForStatus(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'Invalid request. Please check your data and try again.';
    case 401:
      return 'Your session has expired. Please log in again.';
    case 403:
      return 'You don\'t have permission to do this.';
    case 404:
      return 'The requested resource was not found.';
    case 422:
      return 'Some of the data you entered is invalid.';
    case 429:
      return 'Too many attempts. Please wait a moment and try again.';
    case 500:
      return 'Server error. Please try again later.';
    case 502:
    case 503:
      return 'The server is currently unavailable. Please try again later.';
    case 504:
      return 'The server took too long to respond. Please try again later.';
    default:
      return 'Something went wrong. Please try again.';
  }
}

ServerException _exception(String message) {
  return ServerException(errorModel: ErrorModel(errorMessage: message));
}
