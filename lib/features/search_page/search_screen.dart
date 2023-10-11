import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sist_hub/features/search_page/search_result_screen.dart';
import 'package:sist_hub/styles/styles.dart';

import 'search_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchTextController = TextEditingController(text: "bhuvanesh");

  void onSearchSubmit(String searchText) {
    Navigator.of(context).pushNamed(
      SearchResultScreen.routename,
      arguments: searchText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          searchTitle(),
          searchBar(searchTextController, onSearchSubmit),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: const Text(
              "suggestions",
              style: AppTextStyles.commentTitle,
            ),
          ),
          usersList(),
        ],
      ),
    );
  }
}
