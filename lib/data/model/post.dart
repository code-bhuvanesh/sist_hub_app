// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Post {
  final int id;
  final String postimg;
  final String description;
  final String postType;
  final DateTime created;
  final int likes;
  final int userId;
  final String username;
  final String? userProfileUrl;

  Post({
    required this.id,
    required this.postimg,
    required this.description,
    required this.postType,
    required this.created,
    required this.likes,
    required this.userId,
    required this.username,
    this.userProfileUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'postimg': postimg,
      'description': description,
      'postType': postType,
      'created': created.millisecondsSinceEpoch,
      'likes': likes,
      'userId': userId,
      'username': username,
      'userProfileUrl': userProfileUrl,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as int,
      postimg: map['postimg'] as String,
      description: map['description'] as String,
      postType: map['postType'] as String,
      created: DateTime.parse(map['created']),
      likes: map['likes'] as int,
      userId: map['userId'] as int,
      username: map['username'] as String,
      userProfileUrl: map['userProfileUrl'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
  static List<Post> PostsFromJson(String source) {
    dynamic l = json.decode(source);
    l.forEach((element) {
      print(element);
    });
    return List<Post>.from(
      l.map(
        (model) => Post.fromMap(model),
      ),
    );
  }
}

enum PostType { workshop, event, achivement, management, anouncement }
