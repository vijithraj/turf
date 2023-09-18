import 'dart:convert';

import 'package:turf_booking_app/config/constants.dart';
import 'package:turf_booking_app/services/apiServices.dart';

import '../model/turf_model.dart';
import 'package:http/http.dart'as http;
class TurfServices{
 static Future<List<TurfModel>>getArticle()async{
    var respose=await Api().getData(ApiConstants.viewturf);
    if (respose.statusCode==200){
      var body=json.decode(respose.body);
      print(body);
      List<TurfModel>data=List<TurfModel>.from(
          body['data'].map((e)=>TurfModel.fromJson(e)).toList());
      return data;
    }else {
      List<TurfModel>data=[];
      return data;
    }
  }

}