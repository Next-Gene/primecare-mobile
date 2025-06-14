import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/cubit/states.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/login_component.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/sign_up_component.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState()); // ✅ تمرير الحالة الابتدائية بشكل صحيح
  static LoginCubit get(context) => BlocProvider.of(context);
  int x = 0 ;
  int selectedIndex =0;

  bool ispassword = true;


  void login() async{
    try {
      emit(LoginLoading());
      final response = await Dio().post(
          "https://primecareapi.runasp.net/api/v1/Auth/login",
          data: {
            "email": LoginComponent.emailController.text,
            "password": LoginComponent.passwordController.text
          });
      emit(LoginSuccess());
      print(response);
    }catch(e){
      emit(LoginWithError(errMessage: e.toString()));
      print(e.toString());
    }
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