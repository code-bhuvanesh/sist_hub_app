// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static const routename = "/profilePage";
  final int userId;
  const ProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("User profile page"));
  }
}
