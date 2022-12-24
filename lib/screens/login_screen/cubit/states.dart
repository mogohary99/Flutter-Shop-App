import 'package:shop_app2/models/login_model.dart';

abstract class LoginStates{}

class LoginInitialStates extends LoginStates{}

class LoginLoadingStates extends LoginStates{}

class LoginSuccessStates extends LoginStates{
  final LoginModel loginModel;

  LoginSuccessStates(this.loginModel);
}

class LoginErrorStates extends LoginStates{
  final String error;

  LoginErrorStates(this.error);
}

class LoginChangePasswordVisibilityStates extends LoginStates{}