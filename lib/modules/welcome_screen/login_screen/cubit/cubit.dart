import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState()); // ✅ تمرير الحالة الابتدائية بشكل صحيح
  static LoginCubit get(context) => BlocProvider.of(context);
  int x = 0 ;
  int selectedIndex =0;

  bool ispassword = true;


  void togel_see_password(){
    ispassword = !ispassword ;
    emit(LoginPassowrdState());
  }


  void selected_tab_color (int index){
    selectedIndex = index ;
    emit(Change_Color_Selected());
  }
}