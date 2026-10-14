import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/login_model.dart';
import '../../data/repo/login_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginRepo loginRepo;

  AuthCubit(this.loginRepo) : super(AuthInitial());
  Future<void> login({required String phone}) async {
    emit(LoginLoading());
    final response = await loginRepo.login(phone: phone);
    response.fold(
      (errMessage) => emit(LoginError(errMessage: errMessage)),
      (loginModel) => emit(LoginSuccess(loginModel: loginModel)),
    );
  }
}
