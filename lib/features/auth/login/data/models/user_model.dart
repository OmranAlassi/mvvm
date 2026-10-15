import '../../../../../core/const/end_point.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? image;
  final String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData[ApiKey.id],
      name: jsonData[ApiKey.name],
      email: jsonData[ApiKey.email],
      phone: jsonData[ApiKey.phone],
      image: jsonData[ApiKey.message],
      token: jsonData[ApiKey.token],
    );
  }
}
