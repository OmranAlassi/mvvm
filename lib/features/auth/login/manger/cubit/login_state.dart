part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginModel loginModel;
  const LoginSuccess({required this.loginModel});

  @override
  List<Object> get props => [loginModel];
}

final class LoginError extends LoginState {
  final String errMessage;
  const LoginError({required this.errMessage});
  @override
  List<Object> get props => [errMessage];
}
