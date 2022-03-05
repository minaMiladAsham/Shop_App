import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/module/login_page/login_page.dart';
import 'package:shopapp/module/update/update_page.dart';
import 'package:shopapp/shared/colors/colors.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image(
                      width: 100,
                      height: 100,
                      image: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ShopCubit.get(context).profileData!.data!.name , style: TextStyle(fontSize: 18),),
                        SizedBox(height: 5,),
                        Text('Flutter Developer' , style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(15),
                          color: defaultColor,
                        ),
                        child: MaterialButton(
                          onPressed: (){
                            navigateTo(context, UpdatePage());
                          },
                          child: Text('Update' , style: TextStyle(fontSize: 15 , color: Colors.white),),

                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.grey,),
                  SizedBox(width: 20,),
                  Text(ShopCubit.get(context).profileData!.data!.phone , style: TextStyle(fontSize: 15, color: Colors.grey,),),
                ],
              ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.grey,),
                    SizedBox(width: 20,),
                    Text(ShopCubit.get(context).profileData!.data!.email , style: TextStyle(fontSize: 15, color: Colors.grey,),),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.favorite, color: defaultColor,),
                    SizedBox(width: 20,),
                    Text(
                      '${
                        ShopCubit.get(context)
                            .favoritesGetModel!
                            .data!
                            .data
                            .length
                            .toString()
                      } Item(s)', style: TextStyle(fontSize: 15, color: Colors.grey,),),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(15),
                    color: defaultColor,
                  ),
                  child: MaterialButton(
                    onPressed: (){
                      CacheHelper.remove('token').then((value) {
                        navigateAndFinish(context, LoginPage());
                            print(tokenGeneral);
                      });
                    },
                    child: Text('Signout' , style: TextStyle(fontSize: 20,color: Colors.white),),

                  ),
                ),

              ],
            ),
          );
        });
  }
}
