import 'package:flutter/material.dart';

import '../../widgets/commonWidget.dart';
import 'search_widgets.dart';

class SearchResultScreen extends StatefulWidget {
  static const routename = "/searchResultScreen";
  const SearchResultScreen({
    super.key,
    required this.searchText,
  });

  final String searchText;

  @override
  State<SearchResultScreen> createState() => SearchResultScreenState();
}

class SearchResultScreenState extends State<SearchResultScreen> {
  var searchController = TextEditingController();
  @override
  void initState() {
    searchController.text = widget.searchText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            searchBar(searchController, (S) {}),
            usersList(),
          ],
        ),
      ),
    );
  }
}
