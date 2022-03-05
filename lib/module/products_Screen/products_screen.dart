import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/model/categories_model/categories_model.dart';
import 'package:shopapp/model/home_model/home_model.dart';
import 'package:shopapp/shared/colors/colors.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).productModel != null && ShopCubit.get(context).categoriesModel != null,
              builder:(context)=> pageContent (ShopCubit.get(context).productModel! ,ShopCubit.get(context).categoriesModel!,context),
              fallback:(context)=> Center(child: CircularProgressIndicator()));
        });
  }

  Widget pageContent (HomeModel model , CategoriesModel cModel , context){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
          items: model.data!.banners.map((e) =>
        Image(
          image: NetworkImage('${e.image}'),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ).toList(),
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1,
          )),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CATEGORIES' , style: TextStyle(fontSize: 24 , fontWeight: FontWeight.w800,)),
                SizedBox(height: 20,),
                Container(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context , index) => buildCategories(cModel.data!.categoriesList[index]),
                      separatorBuilder: (context , index) => SizedBox(width: 10,),
                      itemCount: cModel.data!.categoriesList.length),
                ),
                SizedBox(height: 20,),
                Text('NEW PRODUCTS' , style: TextStyle(fontSize: 24 , fontWeight: FontWeight.w800,)),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            color: Colors.grey,
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1/1.58,
              children: List.generate(
                  model.data!.products.length,
                  (index) => buildGrid(model.data!.products[index],context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGrid(ProductsModel model , context){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Stack(
           alignment: AlignmentDirectional.bottomStart,
           children: [
             Image(
               image: NetworkImage('${model.image}'
               ),
               width: double.infinity,
               height: 200,
             ),
             if (model.discount != 0)
             Container(
               color: Colors.red,
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 2),
                 child: Text('DISCOUNT' , style: TextStyle(fontSize: 12 , color: Colors.white),),
               ),
             ),
           ],
         ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.name}' ,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.2),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text('${model.price.round()}' ,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.2,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 10,),
                    if (model.discount != 0)
                      Text('${model.oldPrice}' ,
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
                      backgroundColor: ShopCubit.get(context).favoritesListIdAndBool[model.id]! ? defaultColor : Colors.grey,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                          onPressed: (){
                          print("product id : ${model.id}");
                          print("product id : ${model.inFavorites}");
                          ShopCubit.get(context).postFavorites(model.id);
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
    );
  }

  Widget buildCategories(CategoriesData model){
    return Container(
      width: 100,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100,
            width: 100,
          ),
          Container(
              color: Colors.black.withOpacity(0.4),
              width: double.infinity,
              child: Text(
                model.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
