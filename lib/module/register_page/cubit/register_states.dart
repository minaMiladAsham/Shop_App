
import 'package:shopapp/model/Register_model/register_model.dart';

abstract class RegisterPageStates{}

class RegisterPageInitialState extends RegisterPageStates {}

class RegisterPageLoadingState extends RegisterPageStates {}

class RegisterPageSucessState extends RegisterPageStates {
  final RegisterModel rModel;
  RegisterPageSucessState(this.rModel);
}

class RegisterPageErrorState extends RegisterPageStates {

  final String error;
  RegisterPageErrorState(this.error);
}

class RegisterPageChangeEyeState extends RegisterPageStates {}
