import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turf_booking_app/model/model_class.dart';

class NearBy_turf extends StatefulWidget {
  const NearBy_turf({Key? key}) : super(key: key);

  @override
  State<NearBy_turf> createState() => _NearBy_turfState();
}

class _NearBy_turfState extends State<NearBy_turf> {

  List turfStore = [
    turfData(imagepath: "images/turf images1.jpg", name: "CAMP NOU", location: "VATAKARA ", contact: "9745236418"),
    turfData(imagepath: "images/turf images1.jpg", name: "Soccer", location: " Kozhikode", contact: "9745236419"),
    turfData(imagepath:  "images/turf images1.jpg", name: "CAMP NOU", location: " Memunda", contact: "9745236423"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                );
              }, suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          }),
    GridView.builder(
      shrinkWrap: true,
    itemCount: turfStore.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 4.0,
    mainAxisSpacing: 4.0
    ),
    itemBuilder: (BuildContext context, int index){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(""),
          fit: BoxFit.fill,

        ),
      )
    );
    },
    ),
    ],
      ),
    );
  }
}
