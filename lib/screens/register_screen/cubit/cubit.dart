import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/constants.dart';
import '../../../network/dio_helper.dart';
import '../../../network/end_point.dart';
import '/screens/register_screen/cubit/states.dart';

import '../../../models/login_model.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoadingStates());
    DioHelper.postData(url: REGISTER, token: token,data: {
      'email': email,
      'password': password,
      'phone': phone,
      'name' : name,
    }).then((value) {
      print('{valurffffffffffff ${value.data}}');
      loginModel =LoginModel.fromJson(value.data);
      emit(RegisterSuccessStates(loginModel));
    }).catchError((error){
      print('errrrrrrrr ${error.toString()}');
      emit(RegisterErrorStates(error.toString()));
    });
  }

  bool isPassword=true;
  IconData suffix= Icons.visibility;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix= isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityStates());
  }
}
