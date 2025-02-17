import 'package:e_commerce/common/routes/routes.dart';
import 'package:e_commerce/common/routes/routes_name.dart';
import 'package:e_commerce/common/utils/app_colors.dart';
import 'package:e_commerce/modules/authentication/view_model/auth_provider.dart';
import 'package:e_commerce/modules/authentication/view_model/change_password_provider.dart';
import 'package:e_commerce/modules/cart/view_model/cart_provider.dart';
import 'package:e_commerce/modules/checkout/view_model/checkout_provider.dart';
import 'package:e_commerce/modules/main/view_model/store_provider.dart';
import 'package:e_commerce/modules/profile/view_model/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
        ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
      ],
      child: MaterialApp(
        initialRoute: RouteName.splashScreen,
        onGenerateRoute: Routes.genarateRoute,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor)),
      ),
    );
  }
}
