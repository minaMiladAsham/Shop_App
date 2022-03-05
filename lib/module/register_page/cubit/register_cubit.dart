import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/Register_model/register_model.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/end_points/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

import 'register_states.dart';

class RegisterPageCubit extends Cubit<RegisterPageStates>{
  RegisterPageCubit() : super(RegisterPageInitialState());

  static RegisterPageCubit get(context) => BlocProvider.of(context);

  RegisterModel? registerModel;

  void userRegister(String email , String password , String name , String phone)
  {
    emit(RegisterPageLoadingState());

    DioHelper.postData(
      url: Register,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      } ,
      lang: 'ar' ,
      token: tokenGeneral,
    ).then((value)
    {
      registerModel = RegisterModel.fromJson(value.data);
      print(registerModel!.message);
      emit(RegisterPageSucessState(registerModel!));
    }).catchError((error) {
      print('error is :${error.toString()}');
      emit(RegisterPageErrorState(error.toString()));
    });
  }


  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordEye (){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterPageChangeEyeState());
  }

}