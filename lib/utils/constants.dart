//urls

const localUrl = "http://192.168.29.180:8000";
const onlineUrl =
    "https://code-bhuvanesh-congenial-doodle-pq99649q5vv277x4-8000.preview.app.github.dev/";
const loginUrl = "/api/login/";
const getpostsUrl = "/api/getposts";
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
