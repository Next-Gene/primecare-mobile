import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/layout/cubit/states.dart';

import '../../buy_page/buy.dart';
import '../../category_page/category.dart';
import '../../home_page/home.dart';
import '../../profile_page/profile.dart';

class AppCubit extends Cubit<AppStates>
{
 AppCubit () : super(AppInitialState());
 static AppCubit get(context)=> BlocProvider.of(context);

 int selectedIndex = 0;

 final List<Widget> screens = [
   Home_page(),
   Buy_page(),
   Profile_page(),
   Category_page(),
 ];



  void change_bottomnav_bar(int index){
    selectedIndex = index;
    emit(AppChangeBottomNavBarState());
  }

}

