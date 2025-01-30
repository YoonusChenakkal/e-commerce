import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/view/bottom_bar.dart';
import 'package:e_commerce/view/cart_page.dart';
import 'package:e_commerce/view/categories_page.dart';
import 'package:e_commerce/view/home_page.dart';
import 'package:e_commerce/view/login_page.dart';
import 'package:e_commerce/view/profile_page.dart';
import 'package:e_commerce/view/register_page.dart';
import 'package:e_commerce/view/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> genarateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => LoginPage());

      case RouteName.register:
        return MaterialPageRoute(builder: (context) => RegisterPage());

      case RouteName.home:
        return MaterialPageRoute(builder: (context) => HomePage());
      case RouteName.bottomBar:
        return MaterialPageRoute(builder: (context) => BottomBar());
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RouteName.cart:
        return MaterialPageRoute(builder: (context) => CartPage());
      case RouteName.categories:
        return MaterialPageRoute(builder: (context) => CategoriesPage());
      case RouteName.profile:
        return MaterialPageRoute(builder: (context) => ProfilePage());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Somethimg Went Wrong'),
            ),
          ),
        );
    }
  }
}
