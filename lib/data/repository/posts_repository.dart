import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../model/post.dart';

class PostsRepository {
  static var client = http.Client();

  Future<List<Post>> getPosts() async {
    var userToken = CurrentUser.instance.token;
    List<Post> posts = [];
    if (userToken == null) return posts;
    try {
      var url = CurrentUser.instance.url + getpostsUrl;
      var response = await http.get(Uri.parse(url),
          headers: CurrentUser.instance.getAuthorizationHeader);
      posts = Post.PostsFromJson(response.body);
    } on Exception catch (e) {
      print(e);
    }
    return posts;
  }
}
