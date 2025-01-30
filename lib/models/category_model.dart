class Category {
  final int id;
  final String name;
  final String imageUrl;
  final bool enableCategory;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.enableCategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image'],
      enableCategory: json['Enable_category'],
    );
  }
}

class SubCategory {
  final int id;
  final String name;
  final String subCategoryImage;
  final String categoryName;
  final int category;
  final bool enableSubcategory;

  SubCategory({
    required this.id,
    required this.name,
    required this.subCategoryImage,
    required this.categoryName,
    required this.category,
    required this.enableSubcategory,
  });

  // Convert JSON to SubCategory object
  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      subCategoryImage: json['Sub_category_image'],
      categoryName: json['category_name'],
      category: json['Category'],
      enableSubcategory: json['Enable_subcategory'],
    );
  }

  // Convert a list of JSON maps into a list of objects
  static List<SubCategory> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SubCategory.fromJson(json)).toList();
  }
}
