import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turf_booking_app/Design_pages/slote_booking_page.dart';

import '../model/turf_model.dart';
import '../services/turf_Services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
    );
    return Scaffold(
      body: FutureBuilder<List<TurfModel>>(
        future: TurfServices.getTurf(),
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
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        var storeData = snapshot.data![index];
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Booking(id:snapshot.data![index].Id,Name:snapshot.data![index].Name,
                                                    Place:snapshot.data![index].Place)));
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
