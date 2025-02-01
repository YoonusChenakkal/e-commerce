import 'package:e_commerce/models/Carousel_Model.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/poster_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/services/app_urls.dart';
import 'package:e_commerce/services/base_api_services.dart';
import 'package:e_commerce/services/network_services.dart';

class StoreRepository {
  final BaseApiServices _apiServices = NetworkServices();

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await _apiServices.getApi(categoriesUrl);
      return (response as List).map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      print('fetchCategories error: $e');
      rethrow;
    }
  }

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _apiServices.getApi(productsUrl);

      // Access the 'results' key to get the list of products
      final productsList = response['results'] as List<dynamic>? ?? [];

      // Map the list of products to Product instances
      return productsList.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      print('fetchProducts error: $e');
      rethrow;
    }
  }

  Future<List<Product>> fetchTotalProducts() async {
    try {
      final response = await _apiServices.getApi(totalProductsUrl);
      return (response as List).map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      print('fetch total Products error: $e');
      rethrow;
    }
  }

  Future<List<SubCategory>> fetchSubCategories() async {
    try {
      final response = await _apiServices.getApi(subCategoriesUrl);
      return SubCategory.fromJsonList(response as List<dynamic>);
    } catch (e) {
      print('fetchSubCategories error: $e');
      rethrow;
    }
  }

  Future<List<PosterImageModel>> fetchPoster() async {
    try {
      final response = await _apiServices.getApi(posterImageUrl);

      if (response is List) {
        return response
            .map((item) =>
                PosterImageModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            "Unexpected response format: Expected a List but got ${response.runtimeType}");
      }
    } catch (e) {
      print('fetchPoster error: $e');
      rethrow;
    }
  }

  Future<List<CarouselModel>> fetchCarousel() async {
    try {
      final response = await _apiServices.getApi(carouselImageUrl);
      return (response as List)
          .map((json) => CarouselModel.fromJson(json))
          .toList();
    } catch (e) {
      print('fetchCarousel error: $e');
      rethrow;
    }
  }
}
