import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState()); // ✅ تمرير الحالة الابتدائية بشكل صحيح
  static LoginCubit get(context) => BlocProvider.of(context);
  
  final Dio _dio = Dio();
  
  int x = 0 ;  int selectedIndex =0;
  bool ispassword = true;
  String? token;

  Future<void> login({
    required String email,
    required String password
}) async{
    emit(LoginLoading());
    
    try{
      final response = await _dio.post(
        "https://primecareapi.runasp.net/api/v1/Auth/login",
        data: {
          "email": email,
          "password": password
        },
        options: Options(headers: {
          'Content-Type': 'application/json'
        }),
      );

      if(response.statusCode == 200 && response.data['success'] == true){
        emit(LoginSuccess(message: 'Logged in!'));
        token = response.data['token'];
      } else {
        emit(LoginWithError(errMessage: response.data['message'] ?? 'Email or Password wrong'));
      }
      print(response.statusCode);
      print(response.data);
    }catch(e){
      if(e is DioException){
        emit(LoginWithError(errMessage: e.response?.data['message'] ?? e.message ?? 'Server error'));
      } else {
        emit(LoginWithError(errMessage: e.toString()));
      }
    }
  }

  Future<void> signUp({
    required String email,
    required String fname,
    required String lname,
    required String password,
    required String repassword,
    required String userName,
    required String phoneNumber,
  }) async {
      emit(SignupLoading());
    try {
      final response = await _dio.post(
        "https://primecareapi.runasp.net/api/v1/Auth/register",
        data: {
          "email": email,
          "fname": fname,
          "lname": lname,
          "password": password,
          "phoneNumber": phoneNumber,
          "repassword": repassword,
          "userName": userName,
        },
          options: Options(headers: {
            'Content-Type': 'application/json',
          })
      );

      if(response.statusCode == 200 && response.data['success'] == true){
        emit(SignupSuccess(message: 'signed in!'));
      } else {
        emit(SignupWithError(errMessage: response.data['message'] ?? 'check inputs are correct!'));
      }

      print(response.statusCode);
      print(response.data);
    } catch (e) {
      if(e is DioException){
        emit(SignupWithError(errMessage: e.response?.data['message'] ?? e.message ?? 'Server error'));
      } else {
        emit(SignupWithError(errMessage: e.toString()));
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