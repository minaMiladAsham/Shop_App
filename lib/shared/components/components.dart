import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateAndFinish( context , Widget page){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (contexr) => page), (route) => false);
}

void navigateTo( context , Widget page){
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

Widget defaultTextFormField ({
  TextEditingController? controller,
  TextInputType? type,
  FormFieldValidator<String>? validate,
  IconData? prefix,
  IconData? suffix,
  String? label,
  ValueChanged<String>? onSubmit ,
  ValueChanged<String>? onChanged,
  VoidCallback? onSuffixPressed,
  bool isPassword = false,
})=> TextFormField(
    onChanged: onChanged,
    controller: controller,
    obscureText: isPassword,
    keyboardType: type,
    validator: validate,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(onPressed: onSuffixPressed, icon: Icon(suffix)),
      border: OutlineInputBorder(),
      labelText:label,
    ),
    );

enum ToastState {succes , error , warning}

Color chooseToastColor (ToastState state){
  Color color;

  switch (state){
    case ToastState.succes:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

void showToast(ToastState state  , String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

