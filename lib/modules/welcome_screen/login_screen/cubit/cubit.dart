import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/cubit/states.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/login_component.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/sign_up_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../network_api/remote/dio_Helper.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState()); // تمرير الحالة الابتدائية بشكل صحيح
  static LoginCubit get(context) => BlocProvider.of(context);
  int x = 0 ;
  int selectedIndex =0;

  bool ispassword = true;


  void login() async {
    try {
      emit(LoginLoading());

      final response = await DioHelper.postData(
        url: "/api/v1/Auth/login",
        data: {
          "email": LoginComponent.emailController.text,
          "password": LoginComponent.passwordController.text,
        },
      );

      final token = response.data['token']; // ← تأكد من أن السيرفر بيرجع 'token'

      if (token != null) {
        // خزنه في Dio لاستخدامه تلقائيًا في باقي الطلبات
        DioHelper.setToken(token);

        // خزنه في SharedPreferences للوصول له لاحقًا
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        emit(LoginSuccess());
        print("Login Token: $token");
      } else {
        emit(LoginWithError(errMessage: "لم يتم استلام التوكن"));
      }
    } catch (e) {
      emit(LoginWithError(errMessage: e.toString()));
    }
  }




  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }






  void signUp({
    required String email,
    required String fname,
    required String lname,
    required String password,
    required String repassword,
    required String userName,
    required String phoneNumber,
  }) async {
    try {
      emit(SignupLoading());
      final response = await Dio().post(
        "https://primecareapi.runasp.net/api/v1/Auth/register",
        data: {
          "email": email,
          "fname": fname,
          "lname": lname,
          "password": password,
          "repassword": repassword,
          "userName": userName,
          "phoneNumber": phoneNumber,
        },
      );
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupWithError(errMessage: e.toString()));
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