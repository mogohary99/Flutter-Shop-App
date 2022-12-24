import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/components/components.dart';
import '/models/categories_model.dart';
import '/models/home_model.dart';
import '/screens/shop_layout/cubit/cubit.dart';
import '/screens/shop_layout/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesStates){
          if(!state.model.status){
            showToast(message: state.model.message, color: Colors.redAccent);
          }
        }
      },
      builder: (context, state) {
        if (ShopCubit
            .get(context)
            .homeModel == null ||
            ShopCubit
                .get(context)
                .categoryModel == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return productsBuilder(ShopCubit
              .get(context)
              .homeModel!,
              ShopCubit
                  .get(context)
                  .categoryModel!, context);
        }
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoryModel categoryModel,
      context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map((e) =>
                Image(
                  image: NetworkImage('${e.image}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ))
                .toList(),
            options: CarouselOptions(
              height: 200,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryModel.data!.data.length,
              itemBuilder: (context, index) {
                return buildCategoryItem(categoryModel.data!.data[index]);
              },
            ),
          ),
          const Text(
            'New Products',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            mainAxisSpacing: 10,
            //crossAxisSpacing: 1,
            childAspectRatio: 1 / 1.3,
            children: List.generate(
              model.data!.products.length,
                  (index) =>
                  buildGridProduct(
                    model.data!.products[index],
                    context,
                  ),
            ),
          ),
          //const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel product, context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15,
              offset: Offset(0, 10),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image(
                image: NetworkImage('${product.image}'),
                //fit: BoxFit.cover,
                height: 140,
                width: double.infinity,
              ),
              if (product.discount != 0)
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    color: Colors.redAccent,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Text(
            '${product.name}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Text(
                '${product.price.round()}',
                style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              const SizedBox(
                width: 10,
              ),
              if (product.discount != 0)
                Text(
                  '${product.oldPrice.round()}',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  ShopCubit.get(context).changeFavorites(product.id);
                  print(product.id);
                },
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: ShopCubit.get(context).favorites[product.id] ==false ? Colors.grey : Colors.blue,
                  child: const Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            width: 100,
            alignment: Alignment.bottomCenter,
            child: Text(
              '${model.name}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
