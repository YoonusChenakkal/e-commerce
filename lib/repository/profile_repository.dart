import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/services/app_urls.dart';
import 'package:e_commerce/services/base_api_services.dart';
import 'package:e_commerce/services/network_services.dart';
import 'package:flutter/foundation.dart';

class ProfileRepository {
  final BaseApiServices _apiServices = NetworkServices();

  Future<UserModel> fetchUser(userId) async {
    try {
      final response = await _apiServices.getApi('$fetchUserUrl$userId');
      return UserModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('$fetchUserUrl$userId/');
      }

      if (kDebugMode) {
        print('fetchUser Error: $e');
      }
      rethrow;
    }
  }

  Future changeAddress(body, userId) async {
    try {
      final response =
          await _apiServices.patchApi('$fetchAddressUrl$userId/', body);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('changeAddress: $e');
      }
      rethrow;
    }
  }
}
