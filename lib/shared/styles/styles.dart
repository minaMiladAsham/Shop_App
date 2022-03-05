import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopapp/shared/colors/colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: defaultColor,),
    backgroundColor: Colors.white,
    elevation: 0.0,
    actionsIconTheme: IconThemeData(color: defaultColor),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
);