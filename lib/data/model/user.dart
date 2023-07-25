// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String token;
  final String email;

  User({required this.token, required this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['token'] as String,
      email: map['email'] as String,
    );
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
