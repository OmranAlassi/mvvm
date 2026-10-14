// import '../const/end_point.dart';

// class ErrorModel {
//   final String errorMessage;
//   final Errors? errors;

//   ErrorModel({required this.errorMessage, required this.errors});

//   factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
//     return ErrorModel(
//       errorMessage: jsonData[ApiKey.message],
//       errors: jsonData[ApiKey.errors] != null
//           ? Errors.fromJson(jsonData[ApiKey.errors])
//           : null,
//     );
//   }
// }

// class Errors {
//   final List<String>? phone;
//   final List<String>? email;
//   final List<String>? otp;

//   Errors({this.phone, this.email, this.otp});

//   factory Errors.fromJson(Map<String, dynamic> jsonData) {
//     return Errors(
//       phone: jsonData[ApiKey.phone] != null
//           ? List<String>.from(jsonData[ApiKey.phone])
//           : null,
//       email: jsonData[ApiKey.email] != null
//           ? List<String>.from(jsonData[ApiKey.email])
//           : null,
//       otp: jsonData[ApiKey.otp] != null
//           ? List<String>.from(jsonData[ApiKey.otp])
//           : null,
//     );
//   }
// }

import 'package:mvvm/core/const/end_point.dart';

class ErrorModel {
  final String errorMessage;
  final Errors? errors;

  ErrorModel({required this.errorMessage, this.errors});

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    final errors = jsonData[ApiKey.errors];
    return ErrorModel(
      errorMessage:
          jsonData[ApiKey.message]?.toString() ?? 'Something went wrong',
      errors: errors is Map<String, dynamic> ? Errors.fromJson(errors) : null,
    );
  }
}

class Errors {
  final List<String>? phone;
  final List<String>? email;

  Errors({this.phone, this.email});

  factory Errors.fromJson(Map<String, dynamic> jsonData) {
    return Errors(
      phone: _toList(jsonData[ApiKey.phone]),
      email: _toList(jsonData[ApiKey.email]),
    );
  }

  static List<String>? _toList(dynamic value) {
    if (value is List) return value.map((e) => e.toString()).toList();
    if (value is String) return [value];
    return null;
  }
}
