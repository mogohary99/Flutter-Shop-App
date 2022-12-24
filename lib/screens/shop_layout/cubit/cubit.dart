import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/models/change_favorites_model.dart';
import 'package:shop_app2/models/favorites_model.dart';
import 'package:shop_app2/models/login_model.dart';
import '/constants.dart';
import '/models/categories_model.dart';
import '/models/home_model.dart';
import '/network/dio_helper.dart';
import '/network/end_point.dart';
import '/screens/shop_layout/categories_screen.dart';
import '/screens/shop_layout/cubit/states.dart';
import '/screens/shop_layout/favorites_screen.dart';
import '/screens/shop_layout/home_screen.dart';
import '/screens/shop_layout/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomStates());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data!.banners[0].image);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      print('eeerrr ${error.toString()}');
      emit(ShopErrorHomeDataStates());
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print('eeerrrXXXXX  ${error.toString()}');
      emit(ShopErrorCategoriesStates());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] == true
        ? favorites.update(productId, (value) => false)
        : favorites.update(productId, (value) => true);
    emit(ShopChangeFavoritesStates());

    DioHelper.postData(url: FAVORITES, token: token, data: {
      'product_id': productId,
    }).then((value) {
      print(token);
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] == true
            ? favorites.update(productId, (value) => false)
            : favorites.update(productId, (value) => true);
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] == true
          ? favorites.update(productId, (value) => false)
          : favorites.update(productId, (value) => true);

      emit(ShopErrorChangeFavoritesStates());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesStates());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel!.data.toString());
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error) {
      print('eeerrrXXXXX  ${error.toString()}');
      emit(ShopErrorGetFavoritesStates());
    });
  }

  LoginModel? userData;

  void getUserData() {
    emit(ShopLoadingUserDataStates());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userData = LoginModel.fromJson(value.data);
      print(userData!.data!.name.toString());
      emit(ShopSuccessUserDataStates(userData!));
    }).catchError((error) {
      print('eeerrrXXXXX  ${error.toString()}');
      emit(ShopErrorUserDataStates());
    });
  }

  void updateUserData({
  required String name,
    required String email,
    required String phone,
}) {
    emit(ShopLoadingUpdateUserStates());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      }
    ).then((value) {
      userData = LoginModel.fromJson(value.data);
      print(userData!.data!.name.toString());
      emit(ShopSuccessUpdateUserStates(userData!));
    }).catchError((error) {
      print('eeerrrXXXXX  ${error.toString()}');
      emit(ShopErrorUpdateUserStates());
    });
  }
}
