import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/model/home_model/home_model.dart';
import 'package:shopapp/shared/colors/colors.dart';
import 'package:shopapp/shared/components/components.dart';
import 'cubit/search_cubit.dart';
import 'cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchScreenCubit(),
      child: BlocConsumer<SearchScreenCubit,SearchScreenStates>(
        listener: (context , states) {},
        builder : (context , states) {
          return Scaffold(
            appBar: AppBar(
              title: Container(
                  height: 30,
                  width: 90,
                  padding: EdgeInsets.all(5),
                  color: Colors.deepOrange,

                  child: Text('Shop App' , style: TextStyle(color:Colors.white))),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextFormField(
                      label: 'Search',
                      type: TextInputType.text,
                      prefix: Icons.search,
                      validate: (value) {
                        if (value!.isEmpty){
                          print('search should not be empty');
                        }
                        return null;
                      },
                      onSubmit: (searchValue){
                        SearchScreenCubit.get(context).postSearchData(searchValue.toString());
                      }
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context , index) => buildFavoritesItem(ShopCubit.get(context).productModel!.data!.products[index], context),
                      separatorBuilder: (context , index) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      itemCount:SearchScreenCubit.get(context).searchModel!.data!.data.length),
                )
              ],
            ),
          );

        }
      ),
    );
  }
  Widget buildFavoritesItem (ProductsModel data , context){
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
                  image: NetworkImage('${data.image}'),
                  width: 120,
                  height: 120,
                ),
                if (data.discount != 0)
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
                  Text(
                    '${data.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.2),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(data.price.toString() ,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.2,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(width: 10,),
                      if (data.discount != 0)
                        Text(data.oldPrice.toString() ,
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
                        backgroundColor: ShopCubit.get(context).favoritesListIdAndBool[data.id]! ? defaultColor : Colors.grey,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                            ShopCubit.get(context).postFavorites(data.id);
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






