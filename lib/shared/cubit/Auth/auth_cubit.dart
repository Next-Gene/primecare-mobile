import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/Auth/ForgetModel.dart';
import '../../../models/Auth/LoginModel.dart';
import '../../../models/Auth/ResetModel.dart';
import '../../../models/Auth/SignupModel.dart';
import '../../../models/Auth/CodeModel.dart';
import '../../network/DioHelper.dart';
import '../../network/endPoints.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  LoginModel? loginM;
  SignupModel? signupM;
  ForgetModel? forgetM;
  CodeModel? codeM;
  ResetModel? resetM;

  String? _email;
  String? token;
  bool isPasswordVisible = true;

  Future<void>login({
    required String email,
    required String password
  }) async {
    emit(LoginLoading());
    try{
      final response = await DioHelper.postRequest(
          endPoint: LOGIN,
          data: {
            'email': email,
            'password': password
          });
      if(response.statusCode! == 200){
        loginM = LoginModel.fromJson(response.data);
        token = response.data['token'];
        emit(LoginSuccess());
      } else {
        emit(LoginWithError(errMessage: response.data['message']));
      }

      print(response.statusCode);
      print(response.data);
    }catch(e){
      emit(LoginWithError(errMessage: e.toString()));
    }
  }

  Future<void>signup({
    required String email,
    required String fname,
    required String lname,
    required String name,
    required String password,
    required String repassword,
    required String phoneNumber
  }) async {
    emit(SignupLoading());
    try{
      final response = await DioHelper.postRequest(
          endPoint: SIGNUP,
          data: {
            'email': email,
            'fname': fname,
            'lname': lname,
            'password': password,
            'phoneNumber': phoneNumber,
            'repassword': repassword,
            'userName': name
          });
      if(response.statusCode! == 200){
        signupM = SignupModel.fromJson(response.data);
        token = response.data['token'];
        emit(SignupSuccess());
      } else {
        emit(SignupWithError(errMessage: response.data['errors']));
      }

      print(response.statusCode);
      print(response.data);
    }catch(e){
      emit(LoginWithError(errMessage: e.toString()));
    }
  }

  Future<void>forget({
    required String email,
  }) async {
    emit(ForgetLoading());
    try{
      final response = await DioHelper.postRequest(
          endPoint: FORGET,
          data: {
            'email': email
          });
      if(response.statusCode! == 200){
        forgetM = ForgetModel.fromJson(response.data);
        _email = email;
        emit(ForgetSuccess());
      } else {
        emit(ForgetWithError(errMessage: response.data['message']));
      }

      print(response.statusCode);
      print(response.data);
    }catch(e){
      emit(ForgetWithError(errMessage: e.toString()));
    }
  }

  Future<void>code({
    required String code,
  }) async {
    emit(CodeLoading());
    try{
      final response = await DioHelper.postRequest(
          endPoint: CODE,
          data: {
            'code': code,
            'email': _email
          });
      if(response.statusCode! == 200){
        codeM = CodeModel.fromJson(response.data);
        emit(CodeSuccess());
      } else {
        emit(CodeWithError(errMessage: response.data['message']));
      }

      print(response.statusCode);
      print(response.data);
    }catch(e){
      emit(CodeWithError(errMessage: e.toString()));
    }
  }

  Future<void>reset({
    required String password,
    required String repassword
  }) async {
    emit(ResetLoading());
    try{
      final response = await DioHelper.postRequest(
          endPoint: RESET,
          data: {
            'confirmPassword': repassword,
            'email': _email,
            'password': password
          });
      Future.delayed(Duration(seconds: 1), (){
        if(password != repassword){
          emit(ResetWithError(errMessage: response.data['errors']));
        } else {
          resetM = ResetModel.fromJson(response.data);
          emit(ResetSuccess());
        }
      });

      print(response.statusCode);
      print(response.data);
    }catch(e){
      emit(ResetWithError(errMessage: e.toString()));
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged());
  }
}
