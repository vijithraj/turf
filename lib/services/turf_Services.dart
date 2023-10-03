import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking_app/Design_pages/admin_addpart.dart';
import 'package:turf_booking_app/Design_pages/admin_page.dart';
import 'package:turf_booking_app/config/constants.dart';
import 'package:turf_booking_app/services/apiServices.dart';

import '../model/turf_model.dart';
import 'package:http/http.dart' as http;

class TurfServices {
  static Future<List<TurfModel>> getTurf() async {
    SharedPreferences localStorsge = await SharedPreferences.getInstance();
    String token = (localStorsge.getString('token') ?? '');
    var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.viewturf),
        headers: {'x-access-token': token.replaceAll('"', '')});
    /*  var response = await Api().getData(ApiConstants.viewturf);*/
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      if (body.containsKey('data')) {
        List<TurfModel> data = List<TurfModel>.from(
          body['data'].map((e) => TurfModel.fromJson(e)).toList(),
        );
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
}

class SingleTurf {
  static Future<TurfModel> getSingleturf(String Turfid) async {
    SharedPreferences localStorsge = await SharedPreferences.getInstance();
    String token = (localStorsge.getString('token') ?? '');
    var Respose = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.singleTurf + Turfid),
        headers: {'x-access-token': token.replaceAll('"', '')});
    // var Respose=await Api().getData(ApiConstants.singleTurf+Turfid);

    String url = ApiConstants.baseUrl + ApiConstants.singleTurf + Turfid;
    print(url);
    var body = json.decode(Respose.body);
    print(body);
    if (Respose.statusCode == 200) {

      return TurfModel.fromJson(body['data']);
    } else {
      throw Exception("failed to load");
    }
  }
}

class UpdateTurf {
  Future<TurfModel> updateturf(BuildContext context, String name, String number,
      String location, String turfId) async {
    var userData = {"Name": name, "Place": location, "Contact": number};
    try {
      var response =
          await Api().putData(userData, ApiConstants.updateturf + turfId);
      var body = jsonDecode(response.body);
      if (body['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            body['message'],
          ),
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddPart()));
        return TurfModel.fromJson(jsonDecode(response.body));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(body['message']),
        ));
      }
    } catch (e) {
      throw e.toString();
    }
    throw 'Unexpected error occurred';
  }
}
