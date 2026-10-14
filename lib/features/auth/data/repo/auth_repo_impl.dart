import 'package:dartz/dartz.dart';
import '../../../../core/const/end_point.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/service/api_consumer.dart';
import '../models/login_model.dart';
import 'login_repo.dart';

class AuthRepoImpl implements LoginRepo {
  final ApiConsumer api;
  AuthRepoImpl({required this.api});
  @override
  Future<Either<String, LoginModel>> login({required String phone}) async {
    try {
      final response = await api.post(
        EndPoint.login,
        data: {ApiKey.phone: phone},
      );
      final loginModel = LoginModel.fromJson(response);
      return Right(loginModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
