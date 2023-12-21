import 'package:flutter/material.dart';
import 'package:sist_hub/styles/styles.dart';

import '../../widgets/commonWidget.dart';

class FindBusScreen extends StatefulWidget {
  static const routename = "/findbusscreen";
  const FindBusScreen({super.key});

  @override
  State<FindBusScreen> createState() => _FindBusScreenState();
}

class _FindBusScreenState extends State<FindBusScreen> {
  var searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.background,
          child: Column(
            children: [
              customAppBar(
                context: context,
                title: "search Bus",
              ),
              searchBar(
                searchTextController,
                (p0) {},
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemBuilder: (context, index) => BusInfoCard(),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BusInfoCard() {
    var places = [
      "Seenarikuppam",
      "ACS College",
      "Nerkundram",
      "Maduravoyul",
      "Koyambedu",
      "Vadapalani",
      "Velacherry",
      "Bye pass"
    ];

    var viaPlacesText = "";

    for (var p in places) {
      viaPlacesText += "$p>";
    }

    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 1,
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: const Text(
                  "70",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.amber,
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Avadi",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'via: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: viaPlacesText, style: TextStyle()),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("arival time : 9:40 AM"),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(
              //     width: 100,
              //     color: Colors.black,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
