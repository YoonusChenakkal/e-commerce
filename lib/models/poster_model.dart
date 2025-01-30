import 'dart:convert';

class PosterImageModel {
  final int id;
  final String posterHeading;
  final String posterTitle;
  final String posterSubTitle;
  final String posterImage;

  PosterImageModel({
    required this.id,
    required this.posterHeading,
    required this.posterTitle,
    required this.posterSubTitle,
    required this.posterImage,
  });

  // Factory method to create an instance from JSON
  factory PosterImageModel.fromJson(Map<String, dynamic> json) {
    return PosterImageModel(
      id: json['id'],
      posterHeading: json['poster_heading'],
      posterTitle: json['poster_title'],
      posterSubTitle: json['poster_sub_title'],
      posterImage: json['poster_image'],
    );
  }
  // Convert a list of JSON objects to a list of PosterModel objects
  static List<PosterImageModel> fromJsonList(String str) {
    final List<dynamic> jsonData = json.decode(str);
    return jsonData.map((json) => PosterImageModel.fromJson(json)).toList();
  }
}
