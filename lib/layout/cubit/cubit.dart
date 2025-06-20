import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../add_to_card/add_to_cart.dart';
import '../../category_page/category.dart';
import '../../home_page/home.dart';
import '../../home_page/model_product.dart';
import '../../network_api/remote/dio_Helper.dart';
import '../../profile_page/profile.dart';
import '../cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  final List<Widget> screens = [
    Home_page(),
    AddToCart(),
    Profile_page(),
    Category_page(),
  ];

  void change_bottomnav_bar(int index) {
    selectedIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Future<void> initToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      DioHelper.setToken(token);
      print("AppCubit - Token loaded: $token");
    } else {
      print("AppCubit - No token found");
    }
  }

  List<dynamic> category = [];

  void getCategory() {
    DioHelper.getData(
      url: '/api/v1/categories',
      query: {'sort': 'commodo dolor ut occaecat id'},
    ).then((value) {
      print(value.data);
      category = value.data;
      print(category[0]['description']);
      emit(GetCategorySuccessfully());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryError(error: error.toString()));
    });
  }

  void getCategoryScreen() {
    emit(GetCategoryLoading());
    DioHelper.getData(
      url: '/api/v1/categories',
      query: {'sort': 'commodo dolor ut occaecat id'},
    ).then((value) {
      category = value.data;
      emit(GetCategorySuccessfully());
    }).catchError((error) {
      emit(GetCategoryError(error: error.toString()));
    });
  }

  List<ProductModel> products = [];

  void getProducts() {
    emit(GetProductsLoadingState());

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

      print('API Response: ${response.data}');

      final botReply = response.data['response'] ?? "لم يتم تلقي رد";

      emit(AskQuestionSuccessState(botReply));
    } catch (e) {
      print('API Error: $e');
      emit(AskQuestionErrorState(e.toString()));
    }
  }

  List<dynamic> cartItems = [];

  void getCartItems() {
    emit(GetCartLoadingState());

    DioHelper.getData(url: '/api/v1/cart').then((value) {
      final response = value.data;

      if (response is Map<String, dynamic> && response.containsKey('cartItems')) {
        cartItems = List<Map<String, dynamic>>.from(response['cartItems'].map((item) {
          return {
            "productId": item['id'],
            "productName": item['productName'],
            "pictureUrl": item['pictureUrl'],
            "price": item['price'],
            "quantity": item['quantity'],
          };
        }));
      } else {
        cartItems = [];
      }

      emit(GetCartSuccessState());
    }).catchError((error) {
      print('getCartItems Error: $error');
      emit(GetCartErrorState(error.toString()));
    });
  }

  double getTotalCartPrice() {
    double total = 0;

    for (var item in cartItems) {
      if (item != null) {
        final quantity = (item['quantity'] ?? 1) as num;
        final price = (item['price'] ?? 0) as num;
        total += price * quantity;
      }
    }

    return total;
  }

  void increaseQuantity(int index) {
    final item = cartItems[index];
    item['quantity'] = (item['quantity'] ?? 1) + 1;
    emit(GetCartSuccessState());
  }

  void decreaseQuantity(int index) {
    final item = cartItems[index];
    if ((item['quantity'] ?? 1) > 1) {
      item['quantity'] = item['quantity'] - 1;
      emit(GetCartSuccessState());
    }
  }

  // *** هنا نضيف عناصر الطلب (orderItems) التي نأخذها من رد API عند الدفع ***
  List<Map<String, dynamic>> orderItemsFromApi = [];

  void parseOrderItemsFromResponse(Map<String, dynamic> response) {
    if (response.containsKey('orderItems')) {
      final items = response['orderItems'] as List<dynamic>;

      orderItemsFromApi = items.map((item) {
        final product = item['itemOrderd'] ?? {};
        return {
          "productId": product['productItemId'] ?? 0,
          "productName": product['productName'] ?? '',
          "pictureUrl": product['productImageUrl'] ?? '',
          "price": (item['price'] ?? 0).toDouble(),
          "quantity": item['quantity'] ?? 1,
        };
      }).toList();

      emit(OrderItemsParsedSuccessState());
    } else {
      orderItemsFromApi = [];
      emit(OrderItemsParsedErrorState("Response missing orderItems"));
    }
  }


  Future<void> checkoutOrder(Map<String, dynamic> orderData) async {
    emit(CheckOutLoadingState());
    try {
      final response = await DioHelper.postData(
        url: '/api/v1/Order/checkOut',
        data: orderData,
      );

      // نعالج عناصر الطلب من الرد
      parseOrderItemsFromResponse(response.data);

      emit(CheckOutSuccessState(response.data));
    } catch (e) {
      emit(CheckOutErrorState(e.toString()));
    }
  }
}
