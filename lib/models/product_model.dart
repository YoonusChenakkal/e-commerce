class Product {
  final int id;
  final int category;
  final String categoryName;
  final int subCategory;
  final String subCategoryName;
  final String name;
  final double price;
  final double offerPrice;
  final String discount;
  final String description;
  final String imageUrl;
  final String weightMeasurement;
  final double priceForSelectedWeight;
  final bool isOfferProduct;
  final bool isPopularProduct;
  final List<Weight> weights;
  final bool isAvailable;
  final DateTime createdAt;
  final String wholeSalePrice;

  Product({
    required this.id,
    required this.category,
    required this.categoryName,
    required this.subCategory,
    required this.subCategoryName,
    required this.name,
    required this.price,
    required this.offerPrice,
    required this.discount,
    required this.description,
    required this.imageUrl,
    required this.weightMeasurement,
    required this.priceForSelectedWeight,
    required this.isOfferProduct,
    required this.isPopularProduct,
    required this.weights,
    required this.isAvailable,
    required this.createdAt,
    required this.wholeSalePrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: _parseInt(json['id']),
      category: _parseInt(json['category']),
      categoryName: json['category_name'] ?? '',
      subCategory: _parseInt(json['sub_category']),
      subCategoryName: json['sub_category_name'] ?? '',
      name: json['name'] ?? '',
      price: _parseDouble(json['price']),
      offerPrice: _parseDouble(json['offer_price']),
      discount: json['discount'] ?? "0.00",
      description: json['description'] ?? '',
      imageUrl: (json['images'] as List<dynamic>?)?.isNotEmpty == true
          ? json['images'][0]['image'] ?? ''
          : '',
      weightMeasurement: json['weight_measurement'] ?? '',
      priceForSelectedWeight: _parseDouble(json['price_for_selected_weight']),
      isOfferProduct: json['is_offer_product'] ?? false,
      isPopularProduct: json['is_popular_product'] ?? false,
      weights: (json['weights'] as List<dynamic>?)
              ?.map((w) => Weight.fromJson(w))
              .toList() ??
          [],
      isAvailable: json['Available'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      wholeSalePrice: json['whole_sale_price']?.toString() ?? "0.00",
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is String) return double.tryParse(value) ?? 0.0;
    if (value is num) return value.toDouble();
    return 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }
}

class Weight {
  final double price;
  final String weight;
  final int quantity;
  final bool isInStock;
  final String measurement;

  Weight({
    required this.price,
    required this.weight,
    required this.quantity,
    required this.isInStock,
    required this.measurement,
  });

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      price: Product._parseDouble(json['price']),
      weight: json['weight']?.toString() ?? '',
      quantity: Product._parseInt(json['quantity']),
      isInStock: json['is_in_stock'] ?? false,
      measurement: json['measurement'] ?? '',
    );
  }
}
