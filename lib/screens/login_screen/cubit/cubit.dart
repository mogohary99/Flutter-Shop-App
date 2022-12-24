import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/constants.dart';
import 'package:shop_app2/models/login_model.dart';
import 'package:shop_app2/network/dio_helper.dart';
import 'package:shop_app2/network/end_point.dart';
import 'package:shop_app2/screens/login_screen/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingStates());
    DioHelper.postData(url: LOGIN,token: token, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print('{valurffffffffffff ${value.data}}');
      loginModel =LoginModel.fromJson(value.data);
      emit(LoginSuccessStates(loginModel));
    }).catchError((error){
      print('errrrrrrrr ${error.toString()}');
      emit(LoginErrorStates(error.toString()));
    });
  }

  bool isPassword=true;
  IconData suffix= Icons.visibility;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix= isPassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordVisibilityStates());
  }
}
