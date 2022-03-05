import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/module/search/search_screen.dart';
import 'package:shopapp/shared/components/components.dart';


class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state){
        ShopCubit cubit  = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Container(
              height: 30,
                width: 90,
                padding: EdgeInsets.all(5),
                color: Colors.deepOrange,

                child: Text('Shop App' , style: TextStyle(color:Colors.white))),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search,)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,) , label: 'Home',),
              BottomNavigationBarItem(icon: Icon(Icons.account_tree_sharp,) , label: 'Categories',),
              BottomNavigationBarItem(icon: Icon(Icons.beenhere,) , label: 'Favourites',),
              BottomNavigationBarItem(icon: Icon(Icons.settings,) , label: 'Settings',),
                  ],
            onTap: (index){
              cubit.ChangeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
