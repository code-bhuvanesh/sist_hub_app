import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  final String token;
  final String email;

  User({
    required this.token,
    required this.email,
  });

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

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OtherUser {
  final String username;
  final String token;
  final String email;
  final String usertype;

  OtherUser({
    required this.username,
    required this.usertype,
    required this.token,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'token': token,
      'email': email,
      'usertype': usertype,
    };
  }

  factory OtherUser.fromMap(Map<String, dynamic> map) {
    return OtherUser(
      username: map['username'] as String,
      token: map['token'] as String,
      email: map['email'] as String,
      usertype: map['usertype'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OtherUser.fromJson(String source) =>
      OtherUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
