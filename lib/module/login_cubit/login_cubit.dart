import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/login_model/login_model.dart';
import 'package:shopapp/module/login_cubit/login_states.dart';
import 'package:shopapp/shared/end_points/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class loginPageCubit extends Cubit<loginPageStates>{
  loginPageCubit() : super(loginPageInitialState());

  static loginPageCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin(String email , String Password){
    emit(loginPageLoadingState());
    DioHelper.postData(
        url: Login,
        lang: 'ar',
        data: {
          'email' : email,
          'password' : Password,
        },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print('${loginModel!.message}');
      print('${loginModel!.status}');
      emit(loginPageSucessState(loginModel!));
    }).catchError((onError){
      print('Login error :  ${onError.toString()}');
      emit(loginPageErrorState(onError.toString()));
    });
  }
  
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordEye (){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(loginPageChangeEyeState());
  }

}