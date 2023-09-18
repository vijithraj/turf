import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking_app/Design_pages/admin_page.dart';
import 'package:turf_booking_app/Design_pages/user_page.dart';
import 'package:turf_booking_app/model/login_model.dart';

import '../Design_pages/home_page.dart';
import '../config/constants.dart';
import 'apiServices.dart';

class LoginServices {
  String loginid='';
  late var role ;
  var user=2;
  var admin =1;

  late SharedPreferences localStorsge;
  Future<LoginModel> login(
      {required BuildContext context,

        required username,
        required password}) async {
    var userData = {

      "username": username,
      "password": password,
    };
    print(userData);
    try {
      var response = await Api().authData(userData, ApiConstants.Login);
      var body = json.decode(response.body);
      print(body);
      if (body['success'] == true) {
        print(body);
        role=int.parse(json.encode(body['userRole']));
        localStorsge=await SharedPreferences.getInstance();
        localStorsge.setInt('userRole', role);
        localStorsge.setString('loginId',json.encode(body['loginId']));

        if(role==user){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserPart()));
        }else if(role==admin){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Admin()));

        }

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['message'])));

        return LoginModel.fromJson(jsonDecode(response.body));
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
