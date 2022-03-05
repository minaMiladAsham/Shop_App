import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/module/onboarding_page/onboarding_page.dart';
import 'package:shopapp/shared/bloc_observer/bloc_observer.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/styles/styles.dart';
import 'module/login_page/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool finishOnBoarding = CacheHelper.getData('killOnBoarding');
  tokenGeneral = CacheHelper.getData('token');
  print('finish onBoarding = ${finishOnBoarding}');
  print('token = ${tokenGeneral}');
  Widget widget;
  if (finishOnBoarding != null){
    if (tokenGeneral != null){
      widget = ShopLayout();
    }else widget = LoginPage();
  }else widget = OnBoardingScreen();
  runApp(MyApp(finishOnBoarding: finishOnBoarding,widget: widget,));
}

class MyApp extends StatelessWidget {
  final bool finishOnBoarding;
  final Widget widget;
  MyApp({required this.finishOnBoarding , required this.widget});
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (BuildContext context) => ShopCubit()..getProductsData()..getCategoriesData()..getFavoritesData()..getUserProfileData(),
     child: BlocConsumer<ShopCubit , ShopStates>(
       listener: (Context , state){},
       builder: (Context, state){
         return MaterialApp(
           debugShowCheckedModeBanner: false,
           home: widget,
           theme: lightTheme,
         );
       },
     ),
   );
  }


}
