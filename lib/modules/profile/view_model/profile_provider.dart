
import 'package:e_commerce/common/models/user_model.dart';
import 'package:e_commerce/common/services/local_storage.dart';
import 'package:e_commerce/common/utils/utils.dart';
import 'package:e_commerce/modules/profile/repository/profile_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? user;
  bool isLoading = false;
  final ProfileRepository _profileRepo = ProfileRepository();

  fetchUser(BuildContext context) async {
    isLoading = true;
    try {
      final userId = await LocalStorage.getUser();

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

  changeAddress(BuildContext context, body) async {
    isLoading = true;

    try {
      final userId = await LocalStorage.getUser();

      await _profileRepo.changeAddress(body, userId);
      fetchUser(context);
      Navigator.pop(context);

      await Utils.flushBar('Address updated', context, color: Colors.green);

      if (kDebugMode) {
        print('changeAddress: $user');
      }
    } catch (error) {
      if (kDebugMode) {
        print(' changeAddress Error: $error');
      }
      Utils.flushBar(error.toString(), context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
