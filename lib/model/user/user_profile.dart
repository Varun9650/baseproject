class UserProfile {
  final dynamic userId;
  final String username;
  final String email;
  final dynamic mobNo;
  final String fullName;

  UserProfile({
    required this.userId,
    required this.username,
    required this.email,
    required this.mobNo,
    required this.fullName,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'],
      username: json['username'],
      email: json['email'],
      mobNo: json['mob_no'],
      fullName: json['fullName'],

    );
  }
}
