import 'package:e_commerce/models/Carousel_Model.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/poster_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/repository/store_repository.dart';
import 'package:e_commerce/utils/utils.dart';
import 'package:flutter/material.dart';

class StoreProvider extends ChangeNotifier {
  List<Category> categories = [];
  List<Product> products = [];
  List<PosterImageModel> posters = [];
  List<CarouselModel> carousel = [];
  List<SubCategory>subCategories = [];

  int? selectedCategoryId;
  bool isLoading = false;

  final StoreRepository _storeRepository = StoreRepository();

  List<Product> get filteredProducts => selectedCategoryId == null
      ? products
      : products.where((p) => p.category == selectedCategoryId).toList();

  Future<void> fetchCategories(BuildContext context) async {
    try {
      categories = await _storeRepository.fetchCategories();
      notifyListeners();
    } catch (e) {
      Utils.flushBar('Failed to load categories: $e', context);
    }
  }
   Future<void> fetchSubCategories(BuildContext context) async {
    try {
      subCategories = await _storeRepository.fetchSubCategories();
      notifyListeners();
    } catch (e) {
      Utils.flushBar('Failed to fetchCarousel: $e', context);
    }
  }


  Future<void> fetchProducts(BuildContext context) async {
    try {
      products = await _storeRepository.fetchProducts();
      notifyListeners();
    } catch (e) {
      Utils.flushBar('Failed to load products: $e', context);
    }
  }

  Future<void> fetchPosters(BuildContext context) async {
    try {
      posters = await _storeRepository.fetchPoster();
      notifyListeners();
    } catch (e) {
      Utils.flushBar('Failed to load posters: $e', context);
    }
  }

  Future<void> fetchCarousel(BuildContext context) async {
    try {
      carousel = await _storeRepository.fetchCarousel();
      notifyListeners();
    } catch (e) {
      Utils.flushBar('Failed to fetchCarousel: $e', context);
    }
  }
  
  void selectCategory(int? categoryId) {
    selectedCategoryId = categoryId;
    notifyListeners();
  }
}
