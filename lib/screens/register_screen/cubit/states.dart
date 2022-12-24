import '/models/login_model.dart';

abstract class RegisterStates{}

class RegisterInitialStates extends RegisterStates{}

class RegisterLoadingStates extends RegisterStates{}

class RegisterSuccessStates extends RegisterStates{
  final LoginModel loginModel;

  RegisterSuccessStates(this.loginModel);
}

class RegisterErrorStates extends RegisterStates{
  final String error;

  RegisterErrorStates(this.error);
}

class RegisterChangePasswordVisibilityStates extends RegisterStates{}