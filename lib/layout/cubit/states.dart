

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavBar extends ShopStates {}

class ShopProductsSuccessState extends ShopStates {}

class ShopProductsErrorState extends ShopStates {
  final String error;
  ShopProductsErrorState(this.error);
}

class ShopProductsLoadingState extends ShopStates {}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoriesErrorState extends ShopStates {
  final String error;
  ShopCategoriesErrorState(this.error);
}

class ShopCategoriesLoadingState extends ShopStates {}

class ShopChangeFavoritesIconSuccessState extends ShopStates {}

class ShopChangeFavoritesIconErrorState extends ShopStates {
  final String error;
  ShopChangeFavoritesIconErrorState(this.error);
}

class ShopChangeFavoritesIconImediatelyState extends ShopStates {}

class ShopFavoritesLoadingState extends ShopStates {}

class ShopFavoritesSuccessState extends ShopStates {}

class ShopFavoritesErrorState extends ShopStates {
  final String error;
  ShopFavoritesErrorState(this.error);
}

class ShopProfileUserLoadingState extends ShopStates {}

class ShopProfileUserSuccessState extends ShopStates {}

class ShopProfileUserErrorState extends ShopStates {
  final String error;
  ShopProfileUserErrorState(this.error);
}


class UpdatePageSuccesState extends ShopStates {}

class UpdatePageLoadingState extends ShopStates {}

class UpdatePageErrorState extends ShopStates {
  final String error;
  UpdatePageErrorState(this.error);
}
