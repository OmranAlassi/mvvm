part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final LoginModel loginModel;
  const LoginSuccess({required this.loginModel});

  @override
  List<Object> get props => [loginModel];
}

final class LoginError extends AuthState {
  final String errMessage;
  const LoginError({required this.errMessage});
  @override
  List<Object> get props => [errMessage];
}
