abstract class AppStates {}

class AppInitialState extends AppStates{}


class AppChangeBottomNavBarState extends AppStates{}


class GetCategoryLoading extends AppStates {}


class GetCategorySuccessfully extends AppStates{}


class GetCategoryError extends AppStates{
  final String error ;

  GetCategoryError({required this.error});
}