abstract class AppStates {}

class AppInitialState extends AppStates{}


class AppChangeBottomNavBarState extends AppStates{}


class GetCategoryLoading extends AppStates {}


class GetCategorySuccessfully extends AppStates{}


class GetCategoryError extends AppStates{
  final String error ;

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
