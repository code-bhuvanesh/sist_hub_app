import 'dart:convert';

import 'package:sist_hub/utils/constants.dart';
import 'package:http/http.dart' as http;

class ChatsRepository {
  final String wsurl = localUrl + chatRoomUrl;
  final client = http.Client();
  Future<List<Map<String, dynamic>>> getAllChats() async {
    var response = await client.get(
      Uri.parse(localUrl + chatRoomUrl),
      headers: await CurrentUser.instance.getAuthorizationHeader,
    );

    return (jsonDecode(response.body) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }

  Future<String> getRoomname(int userid) async {
    var response = await client.post(
      Uri.parse(localUrl + chatRoomUrl),
      headers: await CurrentUser.instance.getAuthorizationHeader,
      body: {"receiver_user": userid.toString()},
    );
    print("data : ${response.body}");
    var data = jsonDecode(response.body);
    return data['room_key'];
  }

  Future<List<Map<String, dynamic>>> getAllMessages(String roomkey) async {
    var url = "$localUrl$chatRoomUrl$roomkey/";
    var response = await client.get(
      Uri.parse(url),
      headers: await CurrentUser.instance.getAuthorizationHeader,
    );
    print("messages");
    print(response.body);
    var data = (jsonDecode(response.body)["messages"]) as List;
    return data.map((e) => e as Map<String, dynamic>).toList();
  }
}
