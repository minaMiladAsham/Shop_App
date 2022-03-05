import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/module/login_cubit/login_cubit.dart';
import 'package:shopapp/module/login_cubit/login_states.dart';
import 'package:shopapp/module/register_page/register_page.dart';
import 'package:shopapp/shared/colors/colors.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/local/cache_helper.dart';

class LoginPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passowrdController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => loginPageCubit(),
      child: BlocConsumer<loginPageCubit , loginPageStates>(
        listener: (context , state) {
          if (state is loginPageSucessState){

            if(state.loginModel.status){
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                print('token = ${tokenGeneral}');
                showToast( ToastState.succes, state.loginModel.message!);
                tokenGeneral = state.loginModel.data!.token;
                ShopCubit.get(context).getUserProfileData();
                ShopCubit.get(context).getFavoritesData();
                navigateAndFinish(context, ShopLayout());
              });

            }else{
              showToast( ToastState.error, state.loginModel.message!);
            }
          }
        },
        builder: (context , state) {
        return  Scaffold(
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
                      Text('Login',style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),
                      Text('Login now to get new offers',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),),
                      SizedBox(height: 30,),
                      defaultTextFormField(
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email,
                          controller: emailController,
                          validate: (String? value){
                            if (value!.isEmpty){
                              return 'please enter your mail';
                            }else return null;
                          }
                      ),
                      SizedBox(height: 15,),

                      defaultTextFormField(
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock,
                          isPassword: loginPageCubit.get(context).isPassword,
                          suffix: loginPageCubit.get(context).suffix,
                          onSuffixPressed: (){
                            loginPageCubit.get(context).changePasswordEye();
                          },
                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              loginPageCubit.get(context).userLogin(emailController.text, passowrdController.text);
                            }
                          },
                          controller: passowrdController,
                          validate: (String? value){
                            if (value!.isEmpty){
                              return 'password is too short';
                            }else return null;
                          }
                      ),
                      SizedBox(height: 15,),
                      ConditionalBuilder(
                        condition: state is! loginPageLoadingState,
                        builder: (context)=> Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(15),
                            color: defaultColor,
                          ),
                          child: MaterialButton(
                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                  loginPageCubit.get(context).userLogin(emailController.text, passowrdController.text);
                                }
                              },
                              child: Text('Login' , style: TextStyle(fontSize: 20),),

                          ),
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have account ?' , style: TextStyle(fontSize: 12),),
                          TextButton(
                            onPressed: (){
                              navigateTo(context ,RegisterPage() );
                            },
                            child: Text('Register Now', style: TextStyle(fontSize: 15),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        },

      ),
    );
  }
}
