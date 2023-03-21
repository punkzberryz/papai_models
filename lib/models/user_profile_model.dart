class UserProfile {
  const UserProfile({
    required this.displayName,
    this.bio,
  });
  final String displayName;
  final String? bio;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
      displayName: json['displayName'] as String, bio: json['bio'] as String?);

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        if (bio != null) 'bio': bio,
      };

  UserProfile copyWith({
    String? displayName,
    String? bio,
  }) =>
      UserProfile(
        displayName: displayName ?? this.displayName,
        bio: bio ?? this.bio,
      );

  @override
  String toString() => toJson().toString();
}
