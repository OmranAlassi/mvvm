import '../const/end_point.dart';

class ErrorModel {
  final String errorMessage;
  final Errors? errors;

  ErrorModel({required this.errorMessage, required this.errors});

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      errorMessage: jsonData[ApiKey.message],
      errors: jsonData[ApiKey.errors] != null
          ? Errors.fromJson(jsonData[ApiKey.errors])
          : null,
    );
  }
}

class Errors {
  final List<String>? phone;
  final List<String>? email;
  final List<String>? otp;

  Errors({this.phone, this.email, this.otp});

  factory Errors.fromJson(Map<String, dynamic> jsonData) {
    return Errors(
      phone: jsonData[ApiKey.phone] != null
          ? List<String>.from(jsonData[ApiKey.phone])
          : null,
      email: jsonData[ApiKey.email] != null
          ? List<String>.from(jsonData[ApiKey.email])
          : null,
      otp: jsonData[ApiKey.otp] != null
          ? List<String>.from(jsonData[ApiKey.otp])
          : null,
    );
  }
}
