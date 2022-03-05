import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/module/login_page/login_page.dart';
import 'package:shopapp/shared/colors/colors.dart';
import 'package:shopapp/shared/components/components.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterPage extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var registerEmailController = TextEditingController();
  var registerPassowrdController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterPageCubit(),
      child: BlocConsumer<RegisterPageCubit,RegisterPageStates>(
        listener: (context,states) {
          if(states is RegisterPageSucessState){
            if(states.rModel.status){
              showToast(ToastState.succes, states.rModel.message!);
              navigateTo(context, LoginPage());
            }else showToast(ToastState.error, states.rModel.message!);
          }
        },
        builder: (context , states){
         return Scaffold(
           appBar: AppBar(),
           body: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Form(
                   key: formKey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('Register',style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),
                       Text('Register now to get new offers',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),),
                       SizedBox(height: 30,),

                       defaultTextFormField(
                           type: TextInputType.text,
                           label: 'User Name',
                           prefix: Icons.person,
                           controller: nameController,
                           validate: (String? value){
                             if (value!.isEmpty){
                               return 'please enter your Name';
                             }
                           }
                       ),
                       SizedBox(height: 15,),

                       defaultTextFormField(
                           type: TextInputType.number,
                           label: 'Phone',
                           prefix: Icons.phone,
                           controller: phoneController,
                           validate: (String? value){
                             if (value!.isEmpty){
                               return 'please enter your Phone';
                             }
                           }
                       ),
                       SizedBox(height: 15,),

                       defaultTextFormField(
                           type: TextInputType.emailAddress,
                           label: 'Email Address',
                           prefix: Icons.email,
                           controller: registerEmailController,
                           validate: (String? value){
                             if (value!.isEmpty){
                               return 'please enter your mail';
                             }
                           }
                       ),
                       SizedBox(height: 15,),

                       defaultTextFormField(
                           type: TextInputType.visiblePassword,
                           label: 'Password',
                           prefix: Icons.lock,
                           isPassword: RegisterPageCubit.get(context).isPassword,
                           suffix: RegisterPageCubit.get(context).suffix,
                           onSuffixPressed: (){
                             RegisterPageCubit.get(context).changePasswordEye();
                           },
                           controller: registerPassowrdController,
                           validate: (String? value){
                             if (value!.isEmpty){
                               return 'password is too short';
                             }
                           }
                       ),
                       SizedBox(height: 15,),
                       ConditionalBuilder(
                         condition: states is !RegisterPageLoadingState,
                         builder: (context)=> Container(
                           width: double.infinity,
                           height: 40,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadiusDirectional.circular(15),
                             color: defaultColor,
                           ),
                           child: MaterialButton(
                             child: Text('Register' , style: TextStyle(fontSize: 20 , color: Colors.white,),),
                             onPressed: (){
                               RegisterPageCubit.get(context).userRegister(
                                 registerEmailController.text,
                                 registerPassowrdController.text,
                                 nameController.text,
                                 phoneController.text,);
                               // if(formKey.currentState!.validate()){
                               //
                               // }
                             },
                           ),
                         ),
                         fallback: (context) => Center(child: CircularProgressIndicator()),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
         );
        }
      ),
    );
  }
}
