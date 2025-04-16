import 'dart:convert';

class LoggedUserModel {
  final String token;
  final String userId;
  final String fullname;
  final String? username;
  final String email;
  final String firstName;
  final List<String> roles;

  LoggedUserModel({
    required this.token,
    required this.userId,
    required this.fullname,
    this.username,
    required this.email,
    required this.firstName,
    required this.roles,
  });

  // Factory constructor to create a UserModel from a JSON map
  factory LoggedUserModel.fromJson(Map<String, dynamic> json) {
    return LoggedUserModel(
      token: json['token'] as String,
      userId: json['userId'] as String,
      fullname: json['fullname'] as String,
      username: json['username'] as String?,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      roles: List<String>.from(json['roles'] as List<dynamic>),
    );
  }

  // Method to convert UserModel to JSON map
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userId': userId,
      'fullname': fullname,
      'username': username,
      'email': email,
      'firstName': firstName,
      'roles': roles,
    };
  }

  // Method to convert UserModel to a JSON string
  String toJsonString() {
    return json.encode(toJson());
  }

  // Factory constructor to create a UserModel from a JSON string
  factory LoggedUserModel.fromJsonString(String jsonString) {
    return LoggedUserModel.fromJson(json.decode(jsonString));
  }
}
