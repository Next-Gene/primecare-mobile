import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/layout/cubit/states.dart';

import '../../add_to_card/add_to_cart.dart';
import '../../category_page/category.dart';
import '../../home_page/home.dart';
import '../../home_page/model_product.dart';
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

 List<ProductModel> products = [];

 void getProducts() {
   emit(GetProductsLoadingState()); // حالة loading (هنعرفها كمان شوية)

   DioHelper.getData(url: '/api/v1/products').then((value) {
     products = (value.data as List)
         .map((json) => ProductModel.fromJson(json))
         .toList();

     emit(GetProductsSuccessState());
   }).catchError((error) {
     print(error.toString());
     emit(GetProductsErrorState(error: error.toString()));
   });
 }



 Future<void> addToCart(Map<String, dynamic> productData) async {
   emit(AddToCartLoadingState());

   try {
     final value = await DioHelper.postData(
       url: '/api/v1/cart/items',
       data: productData,
     );

     if (value.statusCode == 200 || value.statusCode == 201) {
       emit(AddToCartSuccessState());
     } else {
       emit(AddToCartErrorState("فشل في الإضافة"));
     }
   } catch (error) {
     emit(AddToCartErrorState(error.toString()));
   }
 }


 void askQuestion(String query) async {
   emit(AskQuestionLoadingState());

   try {
     final response = await DioHelper.postData(
       url: '/api/PrimeAi/ask',
       data: {"query": query},
     );

     print('API Response: ${response.data}');  // <<< تأكد هنا من شكل الرد

     final botReply = response.data['response'] ?? "لم يتم تلقي رد";

     emit(AskQuestionSuccessState(botReply));
   } catch (e) {
     print('API Error: $e');  // <<< لو فيه خطأ
     emit(AskQuestionErrorState(e.toString()));
   }
 }





}

