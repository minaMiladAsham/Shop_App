import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/model/favorites_model/favorites_get_model.dart';
import 'package:shopapp/shared/colors/colors.dart';

class FavoritsScreen extends StatelessWidget {
  const FavoritsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition : state is! ShopFavoritesLoadingState,
            builder:(context) => ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context , index)=>buildFavoritesItem(ShopCubit.get(context).favoritesGetModel!.data!.data[index],context),
                separatorBuilder: (context , index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 2,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                ),
                itemCount: ShopCubit.get(context).favoritesGetModel!.data!.data.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }


  Widget buildFavoritesItem (MyData data , context){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 120,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(data.product!.image),
                  width: 120,
                  height: 120,
                ),
                if (data.product!.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text('DISCOUNT' , style: TextStyle(fontSize: 12 , color: Colors.white),),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.product!.name ,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.2),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(data.product!.price.toString() ,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.2,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(width: 10,),
                      if (data.product!.discount != 0)
                        Text(data.product!.oldPrice.toString() ,
                          style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                            color: Colors.grey,
                          ),
                        ),
                      Spacer(),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context).favoritesListIdAndBool[data.product!.id]! ? defaultColor : Colors.grey,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                           ShopCubit.get(context).postFavorites(data.product!.id);
                          },
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
