import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/forget_password/verifyCode.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/forget_password/verifyEmail.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/forget_password/resetPW.dart';

part 'reset_pw_state.dart';

class ResetPwCubit extends Cubit<ResetPwState> {
  ResetPwCubit() : super(ResetPwInitial());
  static ResetPwCubit get(context) => BlocProvider.of(context);

  final Dio _dio = Dio();

  int x = 0 ;  int selectedIndex =0;
  bool ispassword = true;
  String? email;

  Future<void> forgetPW({
  required String email
  }) async{
      emit(EmailLoading());
      try{
      final response = await _dio.post(
          "https://primecareapi.runasp.net/api/v1/Auth/forget-password",
        data: {
            "email": email
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        emit(EmailSuccess(message: response.data['message']));
        email = response.data['email'];
      } else {
        emit(EmailWithError(errMessage: response.data['errMessage'] ?? 'wrong email'));
      }
      print(response.statusCode);
      print(response.data);
    }catch(e){
        if (e is DioException) {
          emit(EmailWithError(errMessage: e.response?.data['errMessage'] ?? e.message ?? 'Server error'));
        } else {
          emit(EmailWithError(errMessage: e.toString()));
        }
    }
  }

  Future<void> codePW({
  required String code
  }) async{
    emit(CodeLoading());
    try{
      final response = await _dio.post(
          "https://primecareapi.runasp.net/api/v1/Auth/verify-code",
          data: {
            "code": code,
            "email": email
          },
        options: Options(headers: {
          'Content-Type': 'application/json',
        })
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        emit(CodeSuccess(message: 'Code verified!'));
      } else {
        emit(CodeWithError(errMessage: response.data['message'] ?? 'wrong code!'));
      }
      print(response.statusCode);
      print(response.data);
    }catch(e){
      if (e is DioException) {
        emit(CodeWithError(errMessage: e.response?.data['message'] ?? e.message ?? 'Server error'));
      } else {
        emit(CodeWithError(errMessage: e.toString()));
      }
    }
  }

  Future<void> ResetPW({
    required String password,
    required String confirmPass
  }) async{
    emit(ResetLoading());
    try{
      final response = await _dio.post(
          "https://primecareapi.runasp.net/api/v1/Auth/reset-password",
          data: {
            "confirmPassword": confirmPass,
            "email": email,
            "password": password
          },
          options: Options(headers: {
            'Content-Type': 'application/json',
          })
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        emit(ResetSuccess(message: 'Password Restarted!'));
      } else {
        emit(ResetWithError(errMessage: response.data['message'] ?? 'must have {lowercase-Uppercase-numbers-simples} and more than 6 chars'));
      }
      print(response.statusCode);
      print(response.data);
    }catch(e){
      if (e is DioException) {
        emit(ResetWithError(errMessage: e.response?.data['message'] ?? e.message ?? 'Server error'));
      } else {
        emit(ResetWithError(errMessage: e.toString()));
      }
    }
  }

  void togel_see_password(){
    ispassword = !ispassword;
    emit(LoginPassowrdState());
  }
  void selected_tab_color (int index){
    selectedIndex = index ;
    emit(Change_Color_Selected());
  }
}
