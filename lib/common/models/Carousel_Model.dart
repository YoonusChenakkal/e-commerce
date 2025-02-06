class CarouselModel {
  final int id;
  final String title;
  final String imageUrl;

  CarouselModel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  // Factory method to create an instance from JSON
  factory CarouselModel.fromJson(Map<String, dynamic> json) {
    return CarouselModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
    );
  }

  // Convert a list of JSON objects to a list of CarouselModel objects
  static List<CarouselModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CarouselModel.fromJson(json)).toList();
  }
}
