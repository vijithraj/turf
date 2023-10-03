import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking_app/model/turf_model.dart';
import 'package:turf_booking_app/services/booking_services.dart';
import 'package:turf_booking_app/services/turf_Services.dart';

import '../config/constants.dart';
import '../model/booking_model.dart';
import '../services/apiServices.dart';
import 'admin_addpart.dart';



enum button{
Button

}
class Booking extends StatefulWidget {
  final String id, Name, Place;

  Booking({required this.id,
  required this.Name,required this.Place});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController Timecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController useridcontroller = TextEditingController();

  late SharedPreferences localStorsge;

  @override
  void initState() {
    feachdetails(widget.id);
    dateInput.text = "";
    timeinput.text = "";
    super.initState();
  }
  bool _isLoading = false;

  String name = '';
  String number = '';
  String location = '';
  String image = '';
  String tufid = '';
  String userId='';
  String place='';
  TurfModel? turfdetails;

  String turfid='';
  String date='';
  String time= '';
  bookModels? bookdetails;

  Future<TurfModel?> feachdetails(String id) async {
    try {
      localStorsge=await SharedPreferences.getInstance();
      userId=(localStorsge.getString('loginId') ?? '').replaceAll(('"'), (''));


      final details = await SingleTurf.getSingleturf(id);
      turfdetails = details;
      print("turf$turfdetails");
      setState(() {
        name = turfdetails!.Name;
        number = turfdetails!.Contact;
        location = turfdetails!.Place;
        image = turfdetails!.Image == null ? "" : turfdetails!.Image;

      });
    } catch (e) {
      print(e);
    }
  }


  bool colorchanges = false;
  button?selectedbutton;
  @override
  Widget build(BuildContext context) {
    //final TextEditingController dateinput = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 200,
            width: 320,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("server/public/images/" +image),
              fit: BoxFit.fill,
            )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.sports_soccer_sharp,
                        color: Colors.white,
                      ),
                      Text(
                        name,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_sharp,
                        color: Colors.red,
                      ),
                      Text(
                       location,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:TextField(
              controller: dateInput,
              //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Enter Date" //label text of field
              ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            )),
            TextField(
              controller: timeinput, //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.timer), //icon of text field
                  labelText: "Enter Time" //label text of field
              ),
              readOnly: true,  //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime =  await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                if(pickedTime != null ){
 setState(() {
                    timeinput.text = pickedTime.format(context).toString(); //set the value of text field.
                  });
                }else{
                  print("Time is not selected");
                }
              },
            ),






          SizedBox(
              width: 170,
              child: ElevatedButton(
                  child: Text("BOOK NOW"),
                  onPressed: () {
                    print(dateInput.text);
                    print(timeinput.text);
                   turfbookServices().turfbooking(context: context,name:widget.Name,
                       place: widget.Place,
                       Time: timeinput.text, Date: dateInput.text, Userid: userId);
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "PAYMENT ALERT",
                      buttons: [
                        DialogButton(
                          onPressed: () => Navigator.pop(context),
                          gradient: const LinearGradient(colors: [
                            Color.fromRGBO(116, 116, 191, 1.0),
                            Color.fromRGBO(52, 138, 199, 1.0)
                          ]),
                          child: const Text(
                            "PAYMENT",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ).show();
                    style:
                    ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ));
                  }))
        ])));
  }
}
