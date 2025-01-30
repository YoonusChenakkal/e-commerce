import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/repository/auth_repository.dart';
import 'package:e_commerce/routes/routes_name.dart';
import 'package:e_commerce/services/local_storage.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:e_commerce/view_model/profile_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
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

      await Provider.of<ProfileProvider>(context, listen: false)
          .fetchUser(context);

      Utils.flushBar('Logged In Successfully', context, color: Colors.blue);
      Navigator.pushNamed(context, RouteName.bottomBar);
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
}
