import 'dart:math';

import 'package:flutter/material.dart';

import '../../styles/styles.dart';

searchTitle() {
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: const Text(
      "search",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
    ),
  );
}

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

usersList({bool showCloseBtn = false}) {
  return Expanded(
    child: ListView.builder(
      // padding: EdgeInsets.only(top: 30),
      itemBuilder: (context, index) => userCard(
        username: students[index],
        year: generateRandomNumber(),
        showCloseBtn: showCloseBtn,
      ),
      itemCount: students.length,
    ),
  );
}

var students = [
  "Krithik",
  "Rajesh",
  "Bharath",
  "Blesston",
  "Ram",
  "Sam",
  "Sammuel",
  "Arjun",
  "Ganesh",
];

int generateRandomNumber() {
  final random = Random();
  int randomNumber = random.nextInt(4) + 1;

  return randomNumber;
}

String generateOrdinal(int number) {
  if (number % 100 >= 11 && number % 100 <= 13) {
    return '$number' + 'th';
  } else {
    switch (number % 10) {
      case 1:
        return '$number' + 'st';
      case 2:
        return '$number' + 'nd';
      case 3:
        return '$number' + 'rd';
      default:
        return '$number' + 'th';
    }
  }
}

userCard({
  bool showCloseBtn = false,
  required String username,
  required int year,
}) {
  return Container(
    width: double.infinity,
    height: 80,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 228, 228, 228),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(children: [
      userProfileIcon(),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: AppTextStyles.postTittleText,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${generateOrdinal(year)} year",
              style: AppTextStyles.postSubTittleText,
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 50,
      ),
      Container(
        // color: Colors.amber,
        padding: EdgeInsets.only(right: 10),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                height: 50,
                // padding: const EdgeInsets.only(left: 100, right: 20),
                child: Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "follow",
                      style: AppTextStyles.buttonTextStyle,
                    ),
                  ),
                ),
              ),
              if (showCloseBtn)
                GestureDetector(
                  onTap: () {
                    print("close btn pressed");
                  },
                  child: Container(
                    child: Icon(Icons.close),
                  ),
                ),
            ],
          ),
        ),
      ),
    ]),
  );
}

Container userProfileIcon() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    height: 60,
    width: 60,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: AppSizes.circleBorder,
          child: Image.asset(
            "assets/images/user_icon.png",
            color: Colors.black87,
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}
