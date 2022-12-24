import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/components.dart';
import '/screens/shop_layout/cubit/cubit.dart';
import '/screens/shop_layout/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {},
        builder: (context, state) {
      ShopCubit cubit = ShopCubit.get(context);
      nameController.text = cubit.userData!.data!.name;
      emailController.text = cubit.userData!.data!.email;
      phoneController.text = cubit.userData!.data!.phone;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if(state is ShopLoadingUpdateUserStates)
                const LinearProgressIndicator(),
                const SizedBox(height: 30),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty!';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email must not be empty!';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone must not be empty!';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  onPressed: () {
                  if(formKey.currentState!.validate()){
                    cubit.updateUserData(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                    );
                  }
                  },
                  minWidth: double.infinity,
                  height: 55,
                  color: Colors.blue,
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  onPressed: () {
                    signOut(context);
                  },
                  minWidth: double.infinity,
                  height: 55,
                  color: Colors.blue,
                  child: const Text(
                    'LOGOUT',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
