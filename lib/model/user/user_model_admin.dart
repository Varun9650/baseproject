class UserModelAdmin {
  final String id;
  final String userId;
  final String userName;
  final String fullName;
  final String email;
  final bool isPunchIn;
  final bool isPunchOut;
  final bool onBreak;

  UserModelAdmin({
    required this.id,
    required this.userId,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.isPunchIn,
    required this.isPunchOut,
    required this.onBreak,
  });

  // Factory method to create a User from JSON
  factory UserModelAdmin.fromJson(Map<String, dynamic> json) {
    return UserModelAdmin(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      userName: json['userName'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      isPunchIn: json['isPunchIn'] ?? false,
      isPunchOut: json['isPunchOut'] ?? false,
      onBreak: json['onBreak'] ?? false,
    );
  }

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'fullName': fullName,
      'email': email,
      'isPunchIn': isPunchIn,
      'isPunchOut': isPunchOut,
      'onBreak': onBreak,
    };
  }
}
