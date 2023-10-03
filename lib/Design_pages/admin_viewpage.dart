import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turf_booking_app/model/booking_model.dart';
import 'package:turf_booking_app/services/booking_services.dart';

class Adminview extends StatefulWidget {
  const Adminview({Key? key}) : super(key: key);

  @override
  State<Adminview> createState() => _AdminviewState();
}

class _AdminviewState extends State<Adminview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<bookModels>>(
        future: AdminviewServices.Adminview(),
        builder:
            (BuildContext context, AsyncSnapshot<List<bookModels>> snapshot) {
          if (snapshot.hasData) {
            print("snap");
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var storeData = snapshot.data![index];
                    print(storeData);
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
