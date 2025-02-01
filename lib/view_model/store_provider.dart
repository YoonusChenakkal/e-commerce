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
  List<Product> totalProducts = [];
  List<PosterImageModel> posters = [];
  List<CarouselModel> carousel = [];
  List<SubCategory> subCategories = [];

  int? selectedCategoryId;
  int? selectedSubCategoryId;

  bool isLoading = false;

  // Getter for filtered products based on selected category
  List<Product> get filteredProducts {
    if (selectedCategoryId == null) {
      return products; // Return all products if no category is selected
    }
    // Filter products based on the selected category
    return products
        .where((product) => product.category == selectedCategoryId)
        .toList();
  }

  // Getter for filtered products based on selected sub-category
  List<Product> get subCatogoryfilteredProducts {
    if (selectedSubCategoryId != null) {
      return totalProducts
          .where((product) => product.subCategory == selectedSubCategoryId)
          .toList();
    }
    // Fallback to category-based filtering if no sub-category is selected
    return selectedCategoryId == null
        ? products
        : totalProducts
            .where((product) => product.category == selectedCategoryId)
            .toList();
  }

  // Update selected category
  void selectCategory(int? categoryId) {
    selectedCategoryId = categoryId;
    notifyListeners();
  }

  // Update selected sub-category
  void selectSubCategory(int? subCategoryId) {
    selectedSubCategoryId = subCategoryId;
    notifyListeners();
  }

  final StoreRepository _storeRepository = StoreRepository();

  // Fetch categories
  Future<void> fetchCategories(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      categories = await _storeRepository.fetchCategories();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      Utils.flushBar('Failed to load categories: $e', context);
    }
  }

  // Fetch sub-categories
  Future<void> fetchSubCategories(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      subCategories = await _storeRepository.fetchSubCategories();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      Utils.flushBar('Failed to fetch sub-categories: $e', context);
    }
  }

  // Fetch products
  Future<void> fetchProducts(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      products = await _storeRepository.fetchProducts();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      Utils.flushBar('Failed to load products: $e', context);
    }
  }

  // Fetch total products
  Future<void> fetchTotalProducts(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      totalProducts = await _storeRepository.fetchTotalProducts();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      Utils.flushBar('Failed to load total products: $e', context);
    }
  }

  // Fetch posters
  Future<void> fetchPosters(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      posters = await _storeRepository.fetchPoster();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      Utils.flushBar('Failed to load posters: $e', context);
    }
  }

  // Fetch carousel
  Future<void> fetchCarousel(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      carousel = await _storeRepository.fetchCarousel();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      Utils.flushBar('Failed to fetch carousel: $e', context);
    }
  }
}
