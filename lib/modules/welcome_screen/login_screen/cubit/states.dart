abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoading extends LoginStates {}
class LoginSuccess extends LoginStates {}
class LoginWithError extends LoginStates {
  final String errMessage;

  LoginWithError({required this.errMessage});
}

class SignupLoading extends LoginStates{}
class SignupSuccess extends LoginStates{}
class SignupWithError extends LoginStates{
  final String errMessage;

  SignupWithError({required this.errMessage});
}

class LoginPassowrdState extends LoginStates {}

class Change_Color_Selected extends LoginStates {}