import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/view_model/profile_provider.dart';
import 'package:e_commerce/view_model/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeApp());
  }

  void _initializeApp() async {
    // Fetch data before navigating
    final storeProvider = Provider.of<StoreProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    storeProvider.fetchProducts(context);
    storeProvider.fetchTotalProducts(context);
    storeProvider.fetchPosters(context);
    storeProvider.fetchCarousel(context);
    storeProvider.fetchCategories(context);
    storeProvider.fetchSubCategories(context);

    // Navigate to Home Screen after 2 seconds
    Future.delayed(Duration(seconds: 2), () async {
      if (profileProvider.user != null) {
        await profileProvider.fetchUser(context);

        Navigator.pushReplacementNamed(context, RouteName.bottomBar);
        return;
      } else {
        Navigator.pushReplacementNamed(context, RouteName.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 150), // Your logo
            SizedBox(height: 20),
            CircularProgressIndicator(), // Loading animation
          ],
        ),
      ),
    );
  }
}
