import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/models/categories_model.dart';
import '/screens/shop_layout/cubit/cubit.dart';
import '/screens/shop_layout/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        ShopCubit cubit=ShopCubit.get(context);
        return ListView.builder(
          itemCount: cubit.categoryModel!.data!.data.length,
          itemBuilder: (context,index){
            return buildCategoryCard(cubit.categoryModel!.data!.data[index]);
          },
        );
      },
    );
  }

  Container buildCategoryCard(DataModel model) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  fit: BoxFit.cover,
                  height: 80,
                  width: 80,
                ),
                Text(
                  '${model.name}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          );
  }
}
