import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/model/categories_model/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context , index) => buildCategoryItem(ShopCubit.get(context).categoriesModel!.data!.categoriesList[index],),
                separatorBuilder: (context , index) => Container(
                  height: 1,
                  color: Colors.grey,
                  width: double.infinity,
                ),
                itemCount: ShopCubit.get(context).categoriesModel!.data!.categoriesList.length,),
          );
        });
  }

  Widget buildCategoryItem (CategoriesData model){
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          child: Image(
            image: NetworkImage(model.image),
            height: 100,
            width: 100,
          ),
        ),
        SizedBox(width: 20),
        Text(model.name , style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    );
  }
}
