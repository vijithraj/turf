import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking_app/Design_pages/home_page.dart';

import '../Design_pages/login_page.dart';
import '../config/constants.dart';
import '../model/booking_model.dart';
import 'package:http/http.dart'as http;

import 'apiServices.dart';

class bookingServices {
  static Future<List<bookModels>> bookTurf() async {
    SharedPreferences localStorsge = await SharedPreferences.getInstance();
    String token = (localStorsge.getString('token') ?? '');
    var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.bokkingturf),);
    /*  var response = await Api().getData(ApiConstants.viewturf);*/
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      if (body.containsKey('data')) {
        List<bookModels> data = List<bookModels>.from(
          body['data'].map((e) => bookModels.fromJson(e)).toList(),
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


class turfbookServices {
  Future<bookModels> turfbooking(
      {required BuildContext context,
        required Time,
        required Date,
        required Userid,
        required String name,
        required String place,

      }) async {
    var userData = {
      "Date": Date,
      "Time": Time,
      "Userid": Userid,
      "Name":name,
      "Place":place,

    };
    print("userData$userData");
    try {
      var response = await Api().authData(userData, ApiConstants.bokkingturf);
      var body = json.decode(response.body);
      print(body);
      if (body['success'] == true) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>Home()));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['message'])));

        return bookModels.fromJson(jsonDecode(response.body));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['message'])));
      }
    } catch (e) {
      throw e.toString();
    }
    throw 'Unexpected error occurred';
  }
}


class AdminviewServices {
  static Future<List<bookModels>> Adminview() async {
    SharedPreferences localStorsge = await SharedPreferences.getInstance();
    String token = (localStorsge.getString('token') ?? '');

    var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.viewturf),
        headers: {'x-access-token': token.replaceAll('"', '')});

    var body = json.decode(response.body);
    print('-----$body');
    if (response.statusCode == 200) {
      if (body.containsKey('data')) {
        List<bookModels> data = List<bookModels>.from(
          body['data'].map((e) => bookModels.fromJson(e)).toList(),
        );
        return data;
      } else {
        throw Exception('Data not found in the response');
      }
    } else {
      throw Exception(
          'Failed to load data. Status Code: ${response.statusCode}');
    }
  }
}



class UserviewServices {
  static Future<List<bookModels>> userview() async {
    SharedPreferences localStorsge = await SharedPreferences.getInstance();
    String token = (localStorsge.getString('token') ?? '');
    var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.viewturf),
        headers: {'x-access-token': token.replaceAll('"', '')});
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      if (body.containsKey('data')) {
        List<bookModels> data = List<bookModels>.from(
          body['data'].map((e) => bookModels.fromJson(e)).toList(),
        );
        return data;
      } else {
        throw Exception('Data not found in the response');
      }
    } else {
      throw Exception(
          'Failed to load data. Status Code: ${response.statusCode}');
    }
  }
}


