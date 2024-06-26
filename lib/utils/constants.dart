import 'package:sist_hub/data/repository/user_repository.dart';
import 'package:sist_hub/utils/secure_storage.dart';

import '../data/model/user.dart';

// const wsurl = "ws://$localdomain";
const wsurl = "wss://laughing-invention-5p559j5pjpqfpxpq-8000.app.github.dev";
const chatSocketUrl = "$wsurl/ws/chats/";

const localdomain = "192.168.29.180:8000";
// const localUrl = "http://$localdomain";
const localUrl =
    "https://laughing-invention-5p559j5pjpqfpxpq-8000.app.github.dev";
// const localUrl = "https://sist-hub-backend.vercel.app";
const onlineUrl =
    "https://code-bhuvanesh-orange-fiesta-gw66pj6w9wjcp7v5-8000.app.github.dev";
const loginUrl = "/api/login/";
const getpostsUrl = "/api/getposts/";
const addpostsUrl = "/api/addposts/";
const likOrUnlikpostsUrl = "/api/likeunlikepost/";
const getCommentsUrl = "/api/getcomments/";
const addCommentsUrl = "/api/addcomments/";
const getUserUrl = "/api/getuser/";
const chatRoomUrl = "/chats/rooms/";
//storage key names
const keyToken = "token";
const keyEmail = "email";

class CurrentUser {
  static final CurrentUser instance = CurrentUser._();
  String url = localUrl;
  String? token;
  int? userId;
  User? user;
  CurrentUser._() {
    // if (token == null) {
    //   getToken();
    // }
  }

  Future<void> loadDefaults() async {
    // var u = await SecureStorage().readSecureData("url");
    // if (u.isNotEmpty) {
    //   url = u;
    // }
    var t = await SecureStorage().readSecureData(keyToken);
    token = (t.isNotEmpty) ? t : null;
    var uid = await SecureStorage().readSecureData("userid");
    userId = (uid.isNotEmpty) ? int.parse(uid) : null;
    if (userId != null) {
      user = await userRepository.getUser(userId.toString());
    }
  }

  void saveDefaults() async {
    await SecureStorage().writeSecureData("url", url);
    await SecureStorage().writeSecureData("userid", user!.id.toString());
  }

  get getAuthorizationHeader async {
    if (token == null) {
      var t = await SecureStorage().readSecureData(keyToken);
      token = (t.isNotEmpty) ? t : null;
    }
    return {"Authorization": "Token $token"};
  }
}
