import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking_app/config/constants.dart';
import 'package:turf_booking_app/model/turf_model.dart';

class NearBy_turf extends StatefulWidget {
  const NearBy_turf({Key? key}) : super(key: key);

  @override
  State<NearBy_turf> createState() => _NearBy_turfState();
}

class _NearBy_turfState extends State<NearBy_turf> {
  List<TurfModel> turf = [];
  List<TurfModel> filteredTurfs = [];

  @override
  void initState() {
    super.initState();
    getTurf();
  }

  Future<List<TurfModel>> getTurf() async {
    SharedPreferences localStorsge = await SharedPreferences.getInstance();
    String token = (localStorsge.getString('token') ?? '');
    print(token.replaceAll('"', ''));

    var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.viewturf),
        headers: {'x-access-token': token.replaceAll('"', '')});
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      if (body.containsKey('data')) {
        print(body);
        List<TurfModel> data = List<TurfModel>.from(
          body['data'].map((e) => TurfModel.fromJson(e)).toList(),
        );
        filteredTurfs = data;
        return data;
      } else {
        // Handle the case where 'data' key is missing in the response.
        throw Exception('Data not found in the response');
      }
    } else {
      throw Exception(
          'Failed to load data. Status Code: ${response.statusCode}');
    }
  }

  void searchHotels(String query) {
    setState(() {
      filteredTurfs = turf
          .where(
              (turf) => turf.Place.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {
                  controller.openView();
                },
                onChanged: (query) {
                  searchHotels(query);
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: filteredTurfs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  final turf = filteredTurfs[index];
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("server/public/images/" +
                            filteredTurfs[index].Image),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(filteredTurfs[index].Name),
                        Text(filteredTurfs[index].Place)
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
