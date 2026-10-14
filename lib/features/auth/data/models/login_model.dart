import '../../../../core/const/end_point.dart';

import 'user_model.dart';

class LoginModel {
  final int code;
  final String message;
  final UserModel? data;
  final dynamic meta;

  LoginModel({required this.code, required this.message, this.data, this.meta});

  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(
      code: jsonData[ApiKey.code],
      message: jsonData[ApiKey.message],
      data: jsonData[ApiKey.data] != null
          ? UserModel.fromJson(jsonData[ApiKey.data])
          : null,
      meta: jsonData[ApiKey.meta],
    );
  }
}
