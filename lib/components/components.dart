import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../network/local/cache_helper.dart';
import '../screens/login_screen/login_screen.dart';

showToast({
  required String message,
  required Color color,
}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

signOut(BuildContext context){
  CacheHelper.removeData(key: 'token').then((value) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  });
}
