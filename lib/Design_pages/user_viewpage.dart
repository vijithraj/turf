import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turf_booking_app/services/booking_services.dart';

import '../model/booking_model.dart';

class UserviewPage extends StatefulWidget {
  const UserviewPage({Key? key}) : super(key: key);

  @override
  State<UserviewPage> createState() => _UserviewPageState();
}

class _UserviewPageState extends State<UserviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<bookModels>>(
        future: UserviewServices.userview(),
        builder:
            (BuildContext context, AsyncSnapshot<List<bookModels>> snapshot) {
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
                                  snapshot.data![index].data.name.toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        snapshot.data![index].data.place.toString(),
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                  ],
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
