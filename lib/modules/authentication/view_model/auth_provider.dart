import 'package:e_commerce/common/routes/routes_name.dart';
import 'package:e_commerce/common/services/local_storage.dart';
import 'package:e_commerce/common/utils/utils.dart';
import 'package:e_commerce/modules/authentication/repository/auth_repository.dart';
import 'package:e_commerce/modules/cart/view_model/cart_provider.dart';
import 'package:e_commerce/modules/profile/view_model/profile_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isOtpGenarated = false;
  final AuthRepository _authRepo = AuthRepository();

  // User login method
  Future<void> userLogin(
      Map<String, dynamic> body, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final value = await _authRepo.userLogin(body);

      if (kDebugMode) {
        print('User Login Value: $value');
      }
      // Save User Data to Shared Prefences
      await LocalStorage.saveUser(value['user_id']);

      // Fetch User Data
      await Provider.of<ProfileProvider>(context, listen: false).fetchUser(
        context,
      );
      Provider.of<CartProvider>(context, listen: false).fetchCart();
      Navigator.pushReplacementNamed(context, RouteName.bottomBar);

      await Utils.flushBar('Logged In Successfully', context,
          color: Colors.blue);
    } catch (error) {
      if (kDebugMode) {
        print('userLogin Error: $error');
      }

      Utils.flushBar(error.toString(), context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  userRegister(Map<String, dynamic> body, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _authRepo.userRegister(body);

      if (kDebugMode) {
        print('User Register Value: $response');
      }

      Utils.flushBar(response['message'], context, color: Colors.blue);
      isOtpGenarated = true;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('userRegister Error: $error');
      }

      Utils.flushBar(error.toString(), context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  verifyOtp(Map<String, dynamic> body, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _authRepo.verifyOtp(body);

      if (kDebugMode) {
        print('Verify OTP Value: $response');
      }
      Navigator.pushReplacementNamed(context, RouteName.login);

      await Utils.flushBar('User Registered,Login Now', context,
          color: Colors.blue);
    } catch (error) {
      if (kDebugMode) {
        print('verifyOtp Error: $error');
      }
      Utils.flushBar(error.toString(), context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
