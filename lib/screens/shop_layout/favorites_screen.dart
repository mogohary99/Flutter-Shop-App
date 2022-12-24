import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/models/favorites_model.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        ShopCubit cubit=ShopCubit.get(context);
        if(state is ShopLoadingGetFavoritesStates){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ListView.builder(
            itemCount: cubit.favoritesModel!.data!.data!.length,
            itemBuilder: (context,index){
              return buildFavoritesCard(cubit.favoritesModel!.data!.data![index],context);
            },
          );
        }

      },
    );
  }

  Container buildFavoritesCard(FavoritesData model, context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Image(
                image: NetworkImage('${model.product!.image}'),
                //fit: BoxFit.cover,
                height: 80,
                width: 80,
              ),
              if (model.product!.discount != 0)
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
          Expanded(
            child: Column(children: [
              Text(
                '${model.product!.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Text(
                    '${model.product!.price!.round()}',
                    style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (model.product!.discount != 0)
                    Text(
                      '${model.product!.oldPrice!.round()}',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model.product!.id);
                      print(model.product!.id);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favorites[model.product!.id] ==false ? Colors.grey : Colors.blue,
                      child: const Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],),
          )

        ],
      ),
    );
  }
}
