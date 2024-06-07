import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/chats_page/chats_page.dart';
import 'package:sist_hub/features/chats_users_page/bloc/chat_users_bloc.dart';
import 'package:sist_hub/features/search_page/search_widgets.dart';

class ChatUsersPage extends StatefulWidget {
  static const routename = "/allchatspage";

  const ChatUsersPage({super.key});

  @override
  State<ChatUsersPage> createState() => _ChatUsersPageState();
}

class _ChatUsersPageState extends State<ChatUsersPage> {
  @override
  void initState() {
    context.read<ChatUsersBloc>().add(GetAllUsersChats());
    super.initState();
  }

  List<Map<String, dynamic>> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "chats",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
      ),
      body: BlocListener<ChatUsersBloc, ChatUsersState>(
        listener: (context, state) {
          if (state is AllUserChats) {
            setState(() {
              users = state.users;
            });
          }
        },
        child: Column(
          children: [
            const Divider(
              thickness: 1.5,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return chatUsers(
                      users[index]["username"],
                      users[index]["id"],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  chatUsers(String username, int id) {
    return
        // const Divider(
        //   color: Colors.grey,
        //   thickness: 0.8,
        // ),
        Column(children: [
      GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          ChatsPage.routename,
          arguments: [
            id,
            username,
          ],
        ),
        child: Container(
          color: const Color.fromARGB(0, 255, 255, 255),
          height: 70,
          width: double.infinity,
          child: Row(children: [
            userProfileIcon(),
            Text(username),
          ]),
        ),
      ),
      const Divider(
        thickness: 1.5,
      )
    ]);
  }
}
