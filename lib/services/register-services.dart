import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:turf_booking_app/Design_pages/login_page.dart';
import 'package:turf_booking_app/config/constants.dart';
import 'package:turf_booking_app/services/apiServices.dart';

import '../model/register-model.dart';

class RegisterServices {
  Future<RegisterModel> register(
      {required BuildContext context,
      required String name,
        required place,
        required address,
        required phone,
        required username,
        required password}) async {
    var userData = {
      "Place": place,
      "name": name,
      "address": address,
      "phone": phone,
      "username": username,
      "password": password,
    };
    try {
      var response = await Api().authData(userData, ApiConstants.register);
      var body = json.decode(response.body);
      if (body['success'] == true) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Login()));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['message'])));

        return RegisterModel.fromJson(jsonDecode(response.body));
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
