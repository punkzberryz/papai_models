class UserContactInfo {
  const UserContactInfo({
    this.phoneNumber,
    this.lineID,
    this.facebook,
  });
  final String? phoneNumber;
  final String? lineID;
  final String? facebook;

  factory UserContactInfo.fromJson(Map<String, dynamic> json) =>
      UserContactInfo(
          phoneNumber: json['phoneNumber'] as String?,
          lineID: json['lineID'] as String?,
          facebook: json['facebook'] as String?);

  Map<String, dynamic> toJson() => {
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (lineID != null) 'lineID': lineID,
        if (facebook != null) 'facebook': facebook,
      };

  UserContactInfo copyWith({
    String? phoneNumber,
    String? lineID,
    String? facebook,
  }) =>
      UserContactInfo(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        lineID: lineID ?? this.lineID,
        facebook: facebook ?? this.facebook,
      );

  @override
  String toString() => toJson().toString();
}

class UserContactInfoBuilder {
  String? phoneNumber;
  String? lineID;
  String? facebook;

  UserContactInfo build() => UserContactInfo(
        phoneNumber: phoneNumber,
        lineID: lineID,
        facebook: facebook,
      );
}
