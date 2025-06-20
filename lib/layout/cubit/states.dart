abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class GetCategoryLoading extends AppStates {}

class GetCategorySuccessfully extends AppStates {}

class GetCategoryError extends AppStates {
  final String error;
  GetCategoryError({required this.error});
}

class GetProductsLoadingState extends AppStates {}

class GetProductsSuccessState extends AppStates {}

class GetProductsErrorState extends AppStates {
  final String error;
  GetProductsErrorState({required this.error});
}

class AddToCartLoadingState extends AppStates {}

class AddToCartSuccessState extends AppStates {}

class AddToCartErrorState extends AppStates {
  final String error;
  AddToCartErrorState(this.error);
}

// ✅ حالات الدفع (Checkout)
class CheckOutLoadingState extends AppStates {}

class CheckOutSuccessState extends AppStates {
  final dynamic data; // الداتا الراجعة من السيرفر
  CheckOutSuccessState(this.data);
}

class CheckOutErrorState extends AppStates {
  final String error;
  CheckOutErrorState(this.error);
}

// ✅ حالات الرد على الأسئلة (Prime AI)
class AskQuestionLoadingState extends AppStates {}

class AskQuestionSuccessState extends AppStates {
  final String botReply;
  AskQuestionSuccessState(this.botReply);
}

class AskQuestionErrorState extends AppStates {
  final String error;
  AskQuestionErrorState(this.error);
}

class GetCartLoadingState extends AppStates {}

class GetCartSuccessState extends AppStates {}

class GetCartErrorState extends AppStates {
  final String error;
  GetCartErrorState(this.error);
}

class OrderItemsParsedSuccessState extends AppStates {}

class OrderItemsParsedErrorState extends AppStates {
  final String error;
  OrderItemsParsedErrorState(this.error);
}

