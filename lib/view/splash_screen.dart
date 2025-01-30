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
    _initializeApp();
  }

  void _initializeApp() async {
    // Fetch data before navigating
    final storeProvider = Provider.of<StoreProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    await profileProvider.fetchUser(context);
    await storeProvider.fetchCategories(context);
    await storeProvider.fetchCategories(context);
    await storeProvider.fetchProducts(context);
    storeProvider.fetchPosters(context);
    storeProvider.fetchCarousel(context);

    // Navigate to Home Screen after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, RouteName.bottomBar);
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
            Image.asset('assets/iconbg.png', width: 150), // Your logo
            SizedBox(height: 20),
            CircularProgressIndicator(), // Loading animation
          ],
        ),
      ),
    );
  }
}
