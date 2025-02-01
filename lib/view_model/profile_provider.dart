import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/repository/profile_repository.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? user;
  bool isLoading = false;
  final ProfileRepository _profileRepo = ProfileRepository();

  fetchUser(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.get('user_id');

      user = await _profileRepo.fetchUser(userId);

      notifyListeners();

      if (kDebugMode) {
        print('fetchUser: $user');
      }
    } catch (error) {
      if (kDebugMode) {
        print(' fetchUser Error: $error');
      }
      Utils.flushBar(error.toString(), context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
