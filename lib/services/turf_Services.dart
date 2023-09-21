import 'dart:convert';

import 'package:turf_booking_app/config/constants.dart';
import 'package:turf_booking_app/services/apiServices.dart';

import '../model/turf_model.dart';
import 'package:http/http.dart'as http;
class TurfServices {
  static Future<List<TurfModel>> getArticle() async {
    String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTAzZGJkMjY0MGUxZjdmOTFkNjdiMjciLCJ1c2VyUm9sZSI6MSwidXNlck5hbWUiOiJhZG1pbiIsImlhdCI6MTY5NTI3OTI0MCwiZXhwIjoxNjk1MjgyODQwfQ.Ghz5P5pek89diR5DUvYrMPDm2X95nQBghHJtE9JPEkI";
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
    } else {
      // Handle non-200 status codes here.
      throw Exception('Failed to load data. Status Code: ${response.statusCode}');
    }
  }
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





