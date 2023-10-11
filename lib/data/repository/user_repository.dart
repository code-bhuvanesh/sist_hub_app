import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sist_hub/data/error/user_error.dart';
import 'package:sist_hub/data/model/user.dart';
import 'package:sist_hub/utils/secure_storage.dart';
import '/utils/constants.dart';

class userRepository {
  static var storage = SecureStorage();

  static var client = http.Client();
  static Future<Either<User, UserError>> loginUser({
    required String email,
    required String password,
    required bool longPressed,
  }) async {
    var postUrl = localUrl + loginUrl;
    var body = {
      "email": email,
      "password": password,
    };
    var loginData = await loggin(postUrl, body);
    if (longPressed) {
      postUrl = onlineUrl + loginUrl;
      CurrentUser.instance.url = onlineUrl;
      CurrentUser.instance.saveDefaults();
    } else {
      CurrentUser.instance.url = localUrl;
      CurrentUser.instance.saveDefaults();
    }

    return loginData;
  }

  static Future<Either<User, UserError>> loggin(
    String loginUrl,
    Map<String, String> body,
  ) async {
    var response = await client.post(Uri.parse(loginUrl), body: body);
    print("login response code : ${response.statusCode}");
    print(response.body);
    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);
      await storage.writeSecureData(keyToken, userData["token"]);
      var user = await getUser(userData["id"].toString());
      //saveing current user
      CurrentUser.instance.user = user;
      await storage.writeSecureData(keyEmail, user.email);
      return Left(user);
    } else if (response.statusCode == 404) {
      return Right(UserError.fromJson(response.body));
    } else {
      return Right(UserError.fromJson(response.body));
    }
  }

  static Future<User> getUser(String id) async {
    var response = await client.post(
      Uri.parse(
        CurrentUser.instance.url + getUserUrl,
      ),
      headers: await CurrentUser.instance.getAuthorizationHeader,
      body: {"userid": id},
    );
    print("user id ${id}");
    print("user response ${response.body}");
    User user = User.fromJson(response.body);
    // User user = User(email: "", id: "3", token: "", userName: "");

    return user;
  }
}
