import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sist_hub/data/error/user_error.dart';
import 'package:sist_hub/data/model/user.dart';
import 'package:sist_hub/utils/secure_storage.dart';
import '/utils/constants.dart';

class userRepository {
  static var storage = SecureStorage();

  static var client = http.Client();
  static Future<Either<User, UserError>> loginUser(
      {required String email,
      required String password,
      required bool longPressed}) async {
    var postUrl = localUrl + loginUrl;

    if (longPressed) {
      postUrl = onlineUrl + loginUrl;
    }

    var body = {
      "email": email,
      "password": password,
    };
    try {
      return await loggin(postUrl, body);
    } on Exception catch (_) {
      postUrl = onlineUrl + loginUrl;
      return loggin(postUrl, body);
    }
  }

  static Future<Either<User, UserError>> loggin(
      String postUrl, Map<String, String> body) async {
    var response = await client.post(Uri.parse(postUrl), body: body);
    print("response code : ${response.statusCode}");
    // print(postUrl);
    // print(response.body);
    if (response.statusCode == 200) {
      var user = User.fromJson(response.body);
      storage.writeSecureData(keyToken, user.token);
      storage.writeSecureData(keyEmail, user.email);
      return Left(user);
    } else if (response.statusCode == 404) {
      return Right(UserError.fromJson(response.body));
    } else {
      return Right(UserError.fromJson(response.body));
    }
  }
}