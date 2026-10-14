import 'package:dartz/dartz.dart';
import '../models/login_model.dart';

abstract class LoginRepo {
  Future<Either<String, LoginModel>> login({required String phone});
}
