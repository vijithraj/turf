import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking_app/config/constants.dart';
import 'package:turf_booking_app/services/apiServices.dart';

import '../model/turf_model.dart';
import 'package:http/http.dart'as http;
class TurfServices {
  static Future<List<TurfModel>> getArticle() async {

     SharedPreferences localStorsge=await SharedPreferences.getInstance();
     String token=(localStorsge.getString('token') ?? '');
     print("token$token");

   var response=await http.get(Uri.parse(ApiConstants.baseUrl+ApiConstants.viewturf),
   headers: {'x-access-token':token}
   );
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
    }else if (response.statusCode == 401) {
      throw UnauthorizedException(
          'Unauthorized: The provided token is invalid or expired.');
    } else {
      throw Exception('Failed to load data. Status Code: ${response.statusCode}');
    }
   /* else {
      // Handle non-200 status codes here.
      throw Exception('Failed to load data. Status Code: ${response.statusCode}');
    }*/
  }
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}

class SingleTurf{
  static Future<List<TurfModel>>getSingleturf(String Turfid)async{
    var Respose=await Api().getData(ApiConstants.singleTurf+Turfid);
    if (Respose.statusCode==200){
      var body=json.decode(Respose.body);
      print(body);
      List<TurfModel>data=
          body['data'].map((e)=>TurfModel.fromJson(e)).toList();
      return data;
    }else {
      List<TurfModel>data=[];
      return data;
    }
  }

}





