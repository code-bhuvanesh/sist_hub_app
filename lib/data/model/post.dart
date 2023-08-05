// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../utils/constants.dart';

class Post {
  final int id;
  final String postimg;
  final String description;
  final String postType;
  final DateTime created;
  int comments;
  int likes;
  bool userLiked = false;
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
    required this.comments,
    required this.userLiked,
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
      'userLiked': userLiked,
      'userId': userId,
      'username': username,
      'userProfileUrl': userProfileUrl,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as int,
      postimg: CurrentUser.instance.url + map['postimg'],
      description: map['description'] as String,
      postType: map['postType'] as String,
      created: DateTime.parse(map['created']),
      comments: map['comments'] as int,
      likes: map['likes'] as int,
      userLiked: map['userLiked'] as bool,
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

enum PostType { general, workshop, event, achivement, management, anouncement }

class PostComment {
  int id;
  String comment;
  int postId;
  int userId;
  DateTime created;
  bool isSubComment;
  int? parentCommentId;

  PostComment({
    required this.id,
    required this.comment,
    required this.postId,
    required this.userId,
    required this.created,
    required this.isSubComment,
    this.parentCommentId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'postId': postId,
      'userId': userId,
      'created': created.millisecondsSinceEpoch,
      'isSubComment': isSubComment,
      'parentComment_id': parentCommentId,
    };
  }

  factory PostComment.fromMap(Map<String, dynamic> map) {
    return PostComment(
      id: map['id'] as int,
      comment: map['comment'] as String,
      postId: map['post_id'] as int,
      userId: map['user_id'] as int,
      created: DateTime.parse(map['created']),
      parentCommentId:
          map['parentCommentId'] != null ? map['parentCommentId'] as int : null,
      isSubComment: map['isSubComment'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostComment.fromJson(String source) =>
      PostComment.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<PostComment> commentsFromJson(String source) {
    dynamic l = json.decode(source);
    print(l);
    l.forEach((element) {
      print(element);
    });
    return List<PostComment>.from(
      l.map(
        (model) => PostComment.fromMap(model),
      ),
    );
  }
}
