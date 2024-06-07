import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/chats_page/bloc/chat_bloc.dart';
import 'package:sist_hub/styles/styles.dart';
import 'package:sist_hub/utils/constants.dart';

class ChatsPage extends StatefulWidget {
  static const routename = "/chatspage";
  final int userid;
  final String username;
  const ChatsPage({
    super.key,
    required this.userid,
    required this.username,
  });

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    context.read<ChatBloc>().add(GetRoomKey(
          userid: widget.userid,
          context: context,
        ));
    super.initState();
  }

  @override
  void dispose() {
    // context.read<ChatBloc>().close();
    scrollController.dispose();
    super.dispose();
  }

  late String roomkey;
  var messages = [];
  var msgController = TextEditingController();
  var scrollController = ScrollController();

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
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is RoomKey) {
            roomkey = state.roomkey;
            context.read<ChatBloc>().add(GetAllMessages(roomkey: roomkey));
          }
          if (state is AllMessages) {
            setState(() {
              messages = state.allMessages;
              scrollController
                  .jumpTo(scrollController.position.minScrollExtent);
            });
            print("check");
            print("scroll : ${scrollController.position}");
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
          }
          if (state is ReceivedMessage) {
            setState(() {
              messages.add(state.message);
            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                curve: Curves.bounceIn,
                duration: const Duration(microseconds: 300),
              );
            });
          }
        },
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
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
                          context.read<ChatBloc>().add(
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
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                curve: Curves.bounceIn,
                                duration: const Duration(microseconds: 300),
                              );
                            });
                            msgController.text = "";
                            FocusManager.instance.primaryFocus?.unfocus();
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
            color: const Color.fromARGB(255, 43, 43, 43),
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
