// product.dart
class Product {
  final int id;
  final int category;
  final String categoryName;
  final String subCategoryName;
  final String name;
  final double price;
  final double offerPrice;
  final String imageUrl;
  final String weightMeasurement;

  Product({
    required this.id,
    required this.category,
    required this.categoryName,
    required this.subCategoryName,
    required this.name,
    required this.price,
    required this.offerPrice,
    required this.imageUrl,
    required this.weightMeasurement,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      category: json['category'],
      categoryName: json['category_name'],
      subCategoryName: json['sub_category_name'],
      name: json['name'],
      price: double.parse(json['price']),
      offerPrice: json['offer_price'],
      imageUrl: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['image']
          : "", // Provide a fallback or handle the missing image case
      weightMeasurement: json['weight_measurement'],
    );
  }
}
