class UserModel {
  final int id;
  final String name;
  final String email;
  final String? mobileNumber;
  final bool isVerified;
  final String? address;
  final String? state;
  final String? city;
  final String? roadName;
  final String? pincode;
  final String? gender;
  final String? dob;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.mobileNumber,
    required this.isVerified,
    this.address,
    this.state,
    this.city,
    this.roadName,
    this.pincode,
    this.gender,
    this.dob,
  });

  /// Factory constructor to create a User from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      mobileNumber: json['mobile_number'] as String?,
      isVerified: json['is_verified'] as bool,
      address: json['address'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      roadName: json['road_name'] as String?,
      pincode: json['pincode'] as String?,
      gender: json['gender'] as String?,
      dob: json['DOB'] as String?,
    );
  }

  /// Method to convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile_number': mobileNumber,
      'is_verified': isVerified,
      'address': address,
      'state': state,
      'city': city,
      'road_name': roadName,
      'pincode': pincode,
      'gender': gender,
      'DOB': dob,
    };
  }
}
