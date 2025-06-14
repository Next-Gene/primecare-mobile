import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/layout/cubit/states.dart';

import '../../add_to_card/add_to_cart.dart';
import '../../category_page/category.dart';
import '../../home_page/home.dart';
import '../../network_api/remote/dio_Helper.dart';
import '../../profile_page/profile.dart';

class AppCubit extends Cubit<AppStates>
{
 AppCubit () : super(AppInitialState());
 static AppCubit get(context)=> BlocProvider.of(context);

 int selectedIndex = 0;

 final List<Widget> screens = [
   Home_page(),
   AddToCart(),
   Profile_page(),
   Category_page(),
 ];



  void change_bottomnav_bar(int index){
    selectedIndex = index;
    emit(AppChangeBottomNavBarState());
  }
  // AAAAAAPPPPPPIIIIII  ( API )
   List<dynamic> category=[] ;

 void getCategory(){
    DioHelper.getData(
        url: '/api/v1/categories',
        query: {
          'sort': 'commodo dolor ut occaecat id'
        }
    ).then((value){
      print(value.data); // تأكيد إن البيانات واصلة
      category = value.data;
       print(category[0]['description']);
      emit(GetCategorySuccessfully());
    }).catchError((error){
      print(error.toString());
      emit(GetCategoryError(error: error.toString()));
    });
  }

 void getCategoryScreen() {
   emit(GetCategoryLoading());
   DioHelper.getData(
     url: '/api/v1/categories',
     query: {
       'sort': 'commodo dolor ut occaecat id',
     },
   ).then((value) {
     category = value.data;
     emit(GetCategorySuccessfully());
   }).catchError((error) {
     emit(GetCategoryError(error: error.toString()));
   });
 }

}

