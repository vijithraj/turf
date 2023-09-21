import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turf_booking_app/Design_pages/slote_booking_page.dart';
import 'package:turf_booking_app/model/model_class.dart';

import '../model/turf_model.dart';
import '../services/turf_Services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 /* List Store = [
    ListData(
        imagepath: "images/turf images1.jpg",
        name: "CAMP NOU",
        location: "VATAKARA ",
        contact: "9745236418"),
    ListData(
        imagepath: "images/turf images1.jpg",
        name: "Soccer",
        location: " Kozhikode",
        contact: "9745236419"),
    ListData(
        imagepath: "images/turf images1.jpg",
        name: "CAMP NOU",
        location: " Memunda",
        contact: "9745236423"),
  ];*/
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
    );
    return Scaffold(
      body: FutureBuilder<List<TurfModel>>(
        future: TurfServices.getArticle(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TurfModel>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SearchAnchor(builder:
                      (BuildContext context, SearchController controller) {
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
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final storeData = snapshot.data?[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(color: Colors.white10, blurRadius: 10)
                            ]),
                            child: Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                  snapshot.data![index].Name.toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        snapshot.data![index].Place.toString(),
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        snapshot.data![index].Contact
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                                leading: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "server/public/images/" +
                                                  snapshot.data![index].Image
                                                      .toString()))),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    /*Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Booking(StoreData: )));*/
                                  },
                                  child: const Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 17,
                                        backgroundImage:
                                            AssetImage("images/next.png"),
                                        backgroundColor: Colors.blueAccent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            );

          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },


      ),
    );
  }
}
