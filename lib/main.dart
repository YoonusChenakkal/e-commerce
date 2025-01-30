import 'package:e_commerce/routes/routes.dart';
import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_model/auth_provider.dart';
import 'package:e_commerce/view_model/cart_provider.dart';
import 'package:e_commerce/view_model/profile_provider.dart';
import 'package:e_commerce/view_model/store_provider.dart';
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
