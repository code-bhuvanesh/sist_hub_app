class Post {
  final int id;
  final int userId;
  final String userName;
  final String imgUrl;
  final PostType postType;
  final List<Comment> comments;
  final int likes;

  Post(
    this.id,
    this.userId,
    this.userName,
    this.imgUrl,
    this.postType,
    this.comments,
    this.likes,
  );
}

enum PostType { workshop, event, achivement, management, anouncement }

class Comment {
  final String id;
  final String commentText;

  Comment(this.id, this.commentText);
}
