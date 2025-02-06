import 'package:e_commerce/common/models/category_model.dart';
import 'package:e_commerce/common/models/product_model.dart';
import 'package:e_commerce/common/routes/routes_name.dart';
import 'package:e_commerce/modules/authentication/view/change_password_page.dart';
import 'package:e_commerce/modules/authentication/view/login_page.dart';
import 'package:e_commerce/modules/authentication/view/register_page.dart';
import 'package:e_commerce/modules/cart/view/cart_page.dart';
import 'package:e_commerce/modules/categories/view/categories_page.dart';
import 'package:e_commerce/modules/checkout/view/checkout_page.dart';
import 'package:e_commerce/modules/common/bottom_bar.dart';
import 'package:e_commerce/modules/common/product_details_page.dart';
import 'package:e_commerce/modules/common/splash_screen.dart';
import 'package:e_commerce/modules/home/home_page.dart';
import 'package:e_commerce/modules/profile/view/profile_page.dart';
import 'package:e_commerce/view/products_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> genarateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => LoginPage());

      case RouteName.register:
        return MaterialPageRoute(builder: (context) => RegisterPage());
      case RouteName.changePassword:
        return MaterialPageRoute(builder: (context) => ChangePasswordPage());
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
      case RouteName.checkout:
        return MaterialPageRoute(builder: (context) => CheckoutPage());

      case RouteName.productDetails:
        final args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => ProductDetailPage(
                  product: args as Product,
                ));

      case RouteName.products:
        final args = settings.arguments as Map<String, dynamic>;
        final category = args['category'] as Category;
        final subCategories = args['subCategories'] as List<SubCategory>;
        return MaterialPageRoute(
            builder: (context) => ProductsPage(
                  category: category,
                  subCategories: subCategories,
                ));

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
