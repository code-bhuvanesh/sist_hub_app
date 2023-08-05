import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import '../../utils/constants.dart';
import '../model/post.dart';
import '../model/user.dart';

class PostsRepository {
  // static var client = http.Client();

  var userToken = CurrentUser.instance.token;
  Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    if (userToken == null) return posts;
    try {
      var url = CurrentUser.instance.url + getpostsUrl;
      var response = await http.get(
        Uri.parse(url),
        headers: CurrentUser.instance.getAuthorizationHeader,
      );
      posts = Post.PostsFromJson(response.body);
    } on Exception catch (e) {
      print(e);
    }
    return posts;
  }

  Future<Map<String, dynamic>> sharePost({
    required String description,
    String postType = "general",
    required File file,
  }) async {
    var url = Uri.parse(CurrentUser.instance.url + addpostsUrl);
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(
      CurrentUser.instance.getAuthorizationHeader,
    );
    request.fields["description"] = description;
    request.fields["postType"] = postType;

    request.files.add(
      await http.MultipartFile.fromPath(
        "postImage",
        file.path,
        contentType: MediaType("image", "jpeg"),
      ),
    );
    var response = await request.send();
    Map<String, dynamic> serverResponse =
        json.decode(await response.stream.bytesToString());
    serverResponse["statuscode"] = response.statusCode;
    print("server response \n $serverResponse");
    return serverResponse;
  }

  Future<Response> getResponse(String subUrl, body) {
    var url = Uri.parse(CurrentUser.instance.url + subUrl);

    var response = http.post(
      url,
      body: body,
      headers: CurrentUser.instance.getAuthorizationHeader,
    );
    return response;
  }

  Future<OtherUser> getUser(int userID) async {
    Map<String, dynamic> body = {"userid": userID.toString()};
    var response = await getResponse(getUserUrl, body);
    return OtherUser.fromJson(response.body);
  }

  Future<Post> likeOrUnlikePost(int postID) async {
    Map<String, dynamic> body = {"postid": postID.toString()};
    var response = await getResponse(likOrUnlikpostsUrl, body);

    return Post.fromJson(response.body);
  }

  Future<List<PostComment>> getPostComments(int postID) async {
    Map<String, dynamic> body = {"postid": postID.toString()};
    var response = await getResponse(getCommentsUrl, body);
    return PostComment.commentsFromJson(response.body);
  }

  Future<String> addComment({
    required int postID,
    required String comment,
  }) async {
    Map<String, dynamic> body = {
      "post": postID.toString(),
      "comment": comment,
      "isSubComment": false.toString(),
    };
    var response = await getResponse(addCommentsUrl, body);
    return response.body;
  }
}

