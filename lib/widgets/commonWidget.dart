import 'package:flutter/material.dart';

searchBar(TextEditingController searchTextController,
    void Function(String) onsumbit) {
  var border = OutlineInputBorder(
    borderSide: const BorderSide(
      width: 2,
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.circular(20),
  );
  return Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 230, 230, 230),
      borderRadius: BorderRadius.circular(20),
    ),
    margin: const EdgeInsets.all(10),
    child: TextField(
      style: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
      controller: searchTextController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          size: 30,
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
      onSubmitted: onsumbit,
    ),
  );
}

Widget backButton(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    icon: const Icon(Icons.arrow_back_ios_new),
    color: Colors.black,
  );
}

Widget customAppBar({required String title, required BuildContext context}) {
  return SafeArea(
    child: Stack(
      children: [
        backButton(context),
        Container(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
