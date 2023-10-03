
import 'package:path/path.dart';
import 'package:turf_booking_app/config/constants.dart';
import 'package:http/http.dart' as http;
class Api{
  authData(data,apiUrl)async{
    var fullUrl=ApiConstants.baseUrl+apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: data,);
  }
  getData(apiUrl)async{
    var fullUrl=ApiConstants.baseUrl+apiUrl;
    return await http.get(
      Uri.parse(fullUrl),);
  }
  postData(apiUrl)async{
    var fullUrl=ApiConstants.baseUrl+apiUrl;
    return await http.post(Uri.parse(fullUrl),
    );
  }
  putData(data,apiUrl)async{
    var fullUrl=ApiConstants.baseUrl+apiUrl;
    return await http.put(
      Uri.parse(fullUrl),
      body: data,);
  }
}