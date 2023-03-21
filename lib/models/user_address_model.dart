class UserAddress {
  const UserAddress({
    required this.province,
    required this.city,
  });
  final String? city;
  final String? province;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        province: json['province'] as String?,
        city: json['city'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'province': province,
        'city': city,
      };

  UserAddress copyWith({String? city, String? province}) =>
      UserAddress(city: city ?? this.city, province: province ?? this.province);

  @override
  String toString() => toJson().toString();
}
