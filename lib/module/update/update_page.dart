import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/layout/shop_layout.dart';

import 'package:shopapp/shared/colors/colors.dart';
import 'package:shopapp/shared/components/components.dart';

class UpdatePage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    var updateEmailController = TextEditingController(text: ShopCubit.get(context).profileData!.data!.email);
    var nameController = TextEditingController(text:ShopCubit.get(context).profileData!.data!.name );
    var phoneController = TextEditingController(text: ShopCubit.get(context).profileData!.data!.phone);

    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state) {},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                Image(
                  width: 100,
                  height: 100,
                  image: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                ),
                SizedBox(height: 20,),

                defaultTextFormField(
                    type: TextInputType.text,
                    prefix: Icons.person,
                    controller: nameController,

                ),
                SizedBox(height: 15,),

                defaultTextFormField(
                    type: TextInputType.number,
                    prefix: Icons.phone,
                    controller: phoneController,

                ),
                SizedBox(height: 15,),

                defaultTextFormField(
                    type: TextInputType.emailAddress,
                    prefix: Icons.email,
                    controller: updateEmailController,
                ),

                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(15),
                    color: defaultColor,
                  ),
                  child: MaterialButton(
                    onPressed: (){
                      ShopCubit.get(context).UpdateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: updateEmailController.text,
                      );
                      ShopCubit.get(context).getUserProfileData();
                      navigateTo(context, ShopLayout());

                    },
                    child: Text('Confirm Update' , style: TextStyle(fontSize: 20,color: Colors.white),),

                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
