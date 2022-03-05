import 'package:shopapp/model/login_model/login_model.dart';

abstract class loginPageStates{}

class loginPageInitialState extends loginPageStates {}

class loginPageLoadingState extends loginPageStates {}

class loginPageSucessState extends loginPageStates {
  final ShopLoginModel loginModel;
  loginPageSucessState(this.loginModel);
}

class loginPageErrorState extends loginPageStates {

  final String error;
  loginPageErrorState(this.error);
}

class loginPageChangeEyeState extends loginPageStates {}


class UpdatePageSuccesState extends loginPageStates {}

class UpdatePageLoadingState extends loginPageStates {}

class UpdatePageErrorState extends loginPageStates {
  final String error;
  UpdatePageErrorState(this.error);
}
