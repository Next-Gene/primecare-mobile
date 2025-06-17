part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}
class LoginSuccess extends AuthState {}
class LoginWithError extends AuthState {
  final String errMessage;
  LoginWithError({required this.errMessage});
}

class SignupLoading extends AuthState {}
class SignupSuccess extends AuthState {}
class SignupWithError extends AuthState {
  final String errMessage;
  SignupWithError({required this.errMessage});
}


class ForgetLoading extends AuthState {}
class ForgetSuccess extends AuthState {}
class ForgetWithError extends AuthState {
  final String errMessage;
  ForgetWithError({required this.errMessage});
}


class CodeLoading extends AuthState {}
class CodeSuccess extends AuthState {}
class CodeWithError extends AuthState {
  final String errMessage;
  CodeWithError({required this.errMessage});
}


class ResetLoading extends AuthState {}
class ResetSuccess extends AuthState {}
class ResetWithError extends AuthState {
  final String errMessage;
  ResetWithError({required this.errMessage});
}

class PasswordVisibilityChanged extends AuthState{}
