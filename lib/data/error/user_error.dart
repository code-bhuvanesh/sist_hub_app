// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserError {
  final String error;

  UserError(this.error);
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
    };
  }

  factory UserError.fromMap(Map<String, dynamic> map) {
    return UserError(
      map['error'] as String,
    );
  }


  factory UserError.fromJson(String source) => UserError.fromMap(json.decode(source) as Map<String, dynamic>);
}
