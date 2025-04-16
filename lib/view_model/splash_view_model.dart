import 'package:base_project/routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashViewModel{
  Future<void> checkNavigation(BuildContext context)async{
    print("Checking nav");
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 3));
    if(!isLoggedIn){
      print("Login nav");
      // Navigate to login
      Navigator.pushReplacementNamed(context, RouteNames.loginView);

    }else{
      print("Home nav");
      // Navigate to home
       Navigator.pushReplacementNamed(context, RouteNames.homeView);
    }

  }
}