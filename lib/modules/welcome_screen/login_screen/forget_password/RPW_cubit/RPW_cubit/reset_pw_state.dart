part of 'reset_pw_cubit.dart';
abstract class ResetPwState {}

class ResetPwInitial extends ResetPwState {}

class EmailLoading extends ResetPwState {}
class EmailSuccess extends ResetPwState {
  final String message;
  EmailSuccess({required this.message});
}
class EmailWithError extends ResetPwState {
  final String errMessage;
  EmailWithError({required this.errMessage});
}

class CodeLoading extends ResetPwState {}
class CodeSuccess extends ResetPwState {
  final String message;
  CodeSuccess({required this.message});
}
class CodeWithError extends ResetPwState {
  final String errMessage;
  CodeWithError({required this.errMessage});
}

class ResetLoading extends ResetPwState {}
class ResetSuccess extends ResetPwState {
  final String message;
  ResetSuccess({required this.message});
}
class ResetWithError extends ResetPwState {
  final String errMessage;
  ResetWithError({required this.errMessage});
}

class LoginPassowrdState extends ResetPwState {}

class Change_Color_Selected extends ResetPwState {}