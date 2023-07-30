//urls

const localUrl = "http://192.168.29.180:8000";
const onlineUrl =
    "https://code-bhuvanesh-orange-fiesta-gw66pj6w9wjcp7v5-8000.preview.app.github.dev/";
const loginUrl = "/api/login/";
const getpostsUrl = "/api/getposts/";
const addpostsUrl = "/api/addposts/";
const likOrUnlikpostsUrl = "/api/likeunlikepost/";
//storage key names
const keyToken = "token";
const keyEmail = "email";

class CurrentUser {
  static final CurrentUser instance = CurrentUser._();
  String url = localUrl;
  String? token;
  CurrentUser._() {
    // if (token == null) {
    //   getToken();
    // }
  }

  get getAuthorizationHeader {
    return {"Authorization": "Token $token"};
  }
}
