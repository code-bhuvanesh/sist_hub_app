import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/chats_page/bloc/chats_bloc.dart';
import 'package:sist_hub/styles/styles.dart';
import 'package:sist_hub/utils/constants.dart';

class chatsPage extends StatefulWidget {
  static const routename = "/chatspage";
  final int userid;
  final String username;
  const chatsPage({
    super.key,
    required this.userid,
    required this.username,
  });

  @override
  State<chatsPage> createState() => _chatsPageState();
}

class _chatsPageState extends State<chatsPage> {
  @override
  void initState() {
    context.read<ChatsBloc>().add(GetRoomName(userid: widget.userid));
    super.initState();
  }

  late String roomkey;
  var messages = [];
  var msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.username,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        // centerTitle: true,
        backgroundColor: Colors.white,
        // elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
      ),
      body: BlocListener<ChatsBloc, ChatsState>(
        listener: (context, state) {
          if (state is RoomKey) {
            roomkey = state.roomkey;
            context.read<ChatsBloc>().add(GetAllMessages(roomkey: roomkey));
          }
          if (state is AllMessages) {
            setState(() {
              messages = state.allMessages;
            });
          }
          if (state is ReceivedMessage) {
            setState(() {
              messages.add(state.message);
            });
          }
        },
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) => messageWidget(
                messages[index]["message"],
                messages[index]["isSender"],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: msgController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: AppSizes.border25,
                          borderSide: const BorderSide(
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: AppSizes.border25,
                        ),
                        hintText: "enter a message...",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7),
                    child: ClipRRect(
                      borderRadius: AppSizes.border25,
                      child: GestureDetector(
                        onTap: () {
                          context.read<ChatsBloc>().add(
                                SendMessage(
                                  message: {
                                    "message": msgController.text,
                                    "sender": CurrentUser.instance.userId,
                                    "receiver": widget.userid,
                                    "sender_name":
                                        CurrentUser.instance.user!.username,
                                  },
                                ),
                              );
                          setState(() {
                            messages.add({
                              "message": msgController.text,
                              "isSender": true,
                            });
                            msgController.text = "";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: Colors.black,
                          child: const Icon(
                            Icons.send,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  messageWidget(String msg, bool isSender) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: ClipRRect(
          borderRadius: AppSizes.border25,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: w / 2.2,
              // minWidth: 70,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black,
            child: Text(
              msg,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
