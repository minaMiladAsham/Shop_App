import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/model/categories_model/categories_model.dart';
import 'package:shopapp/model/favorites_model/favorites_get_model.dart';
import 'package:shopapp/model/favorites_model/favorites_post_model.dart';
import 'package:shopapp/model/home_model/home_model.dart';
import 'package:shopapp/model/login_model/login_model.dart';
import 'package:shopapp/model/profile_model/profile_model.dart';
import 'package:shopapp/module/categories_Screen/categories_screen.dart';
import 'package:shopapp/module/favorits_Screen/favorits_screen.dart';
import 'package:shopapp/module/products_Screen/products_screen.dart';
import 'package:shopapp/module/settings_Screen/settings_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/end_points/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit(): super(ShopInitialStates());

  static ShopCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritsScreen(),
    SettingsScreen(),
  ];



  void ChangeBottomNavBar(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavBar());
  }
    HomeModel? productModel ;
    CategoriesModel? categoriesModel;
    Map<int? , bool?> favoritesListIdAndBool = {};
    FavoritesPostModel? favouritesModelList;
    FavoritesGetModel? favoritesGetModel;

  void getProductsData(){
    emit(ShopProductsLoadingState());
    DioHelper.getData(
        url: Home,
        lang: 'en',
        token: tokenGeneral,
    ).then((value) {
      productModel = HomeModel.fromJson(value.data);
      print('product id : ${productModel!.data!.banners[0].id}');
      print('product status : ${productModel!.status}');
      productModel!. data!.products.forEach((element) {
        favoritesListIdAndBool.addAll(
            {
              element.id: element.inFavorites
            });
      });
      print(favoritesListIdAndBool.toString());
      emit(ShopProductsSuccessState());
    }).catchError((onError){
      print('Product Screen Error ${onError.toString()}');
      emit(ShopProductsErrorState(onError.toString()));
    });
  }

  void getCategoriesData(){
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(
      url: Categories,
      lang: 'en',
      token: tokenGeneral,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print('cat.Data name = ${categoriesModel!.data!.categoriesList[0].name}');
      emit(ShopCategoriesSuccessState());
    }).catchError((onError){
      print('Categories Screen Error ${onError.toString()}');
      emit(ShopCategoriesErrorState(onError.toString()));
    });
  }

  void postFavorites (int? productId){

    favoritesListIdAndBool[productId] = !favoritesListIdAndBool[productId]!;
    emit(ShopChangeFavoritesIconImediatelyState());

    DioHelper.postData(
        url: Favorites,
        data: {
          'product_id' : productId,
        },
       token: tokenGeneral,
    ).then((value) {
      favouritesModelList = FavoritesPostModel.fromJson(value.data);
      if(!favouritesModelList!.status){
        favoritesListIdAndBool[productId] = !favoritesListIdAndBool[productId]!;
        showToast(ToastState.error, favouritesModelList!.message);
      }else {
        getFavoritesData();
      }
      emit(ShopCategoriesLoadingState());
    })
        .catchError((onError){
          print('Change favorites icon error : ${onError.toString()}');
          emit(ShopChangeFavoritesIconErrorState(onError));
    });
  }

  void getFavoritesData(){
    emit(ShopFavoritesLoadingState());
    DioHelper.getData(
      url: Favorites,
      lang: 'en',
      token: tokenGeneral,
    ).then((value) {
      favoritesGetModel = FavoritesGetModel.fromJson(value.data);
      emit(ShopFavoritesSuccessState());
    }).catchError((onError){
      print('favorites Screen Error ${onError.toString()}');
      emit(ShopFavoritesErrorState(onError.toString()));
    });
  }

  ProfileModel? profileData;

  void getUserProfileData(){
    emit(ShopProfileUserLoadingState());
    DioHelper.getData(
      url: Profile,
      lang: 'ar',
      token: tokenGeneral,
    ).then((value) {
       profileData = ProfileModel.fromJson(value.data);
      print('user data : ${profileData!.data!.name}');
      emit(ShopProfileUserSuccessState());
    }).catchError((onError){
      print('Settings Screen Error ${onError.toString()}');
      emit(ShopProfileUserErrorState(onError.toString()));
    });
  }

  
  ShopLoginModel? loginModel;

  void UpdateUserData({
    String? email,
    String? name,
    String? phone,
  }){
    emit(UpdatePageLoadingState());
    DioHelper.PutData(
      url: Update,
      lang: 'ar',
      token: tokenGeneral,
      data: {
        'email' : email,
        'name' : name,
        'phone' : phone,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print('update status ${loginModel!.status}');
      emit(UpdatePageSuccesState());
    }).catchError((onError){
      print('update error :  ${onError.toString()}');
      emit(UpdatePageErrorState(onError.toString()));
    });
  }

}