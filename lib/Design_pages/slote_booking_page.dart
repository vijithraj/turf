import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../model/model_class.dart';
enum button{
 Button;
}
class Booking extends StatefulWidget {
  final ListData StoreData;

  Booking({required this.StoreData});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  /*void initState() {
    dateinput.text = "";
    super.initState();
  }*/
  bool colorchanges = false;
  button?selectedbutton;
  @override
  Widget build(BuildContext context) {
    final TextEditingController dateinput = TextEditingController();
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
              image: AssetImage(widget.StoreData.imagepath.toString()),
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
                        widget.StoreData.name.toString(),
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_sharp,
                        color: Colors.red,
                      ),
                      Text(
                        widget.StoreData.location.toString(),
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
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dateinput,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate);
                  setState(() {
                    dateinput.text = formattedDate;
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ),
          const Text(
            "SELECT YOUR TIME",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(
            height: 8,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "DAY",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildOutlinedButton("6-7"),
              buildOutlinedButton("7-8"),
              buildOutlinedButton("8-9"),
              buildOutlinedButton("9-10"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildOutlinedButton("10-11"),
              buildOutlinedButton("11-12"),
              buildOutlinedButton("12-1"),
              buildOutlinedButton("1-2"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildOutlinedButton("2-3"),
              buildOutlinedButton("3-4"),
              buildOutlinedButton("4-5"),
              buildOutlinedButton("5-6"),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "NIGHT",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildOutlinedButton("6-7"),
              buildOutlinedButton("7-8"),
              buildOutlinedButton("8-9"),
              buildOutlinedButton("9-10"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildOutlinedButton("10-11"),
              buildOutlinedButton("11-12"),
              buildOutlinedButton("12-1"),
              buildOutlinedButton("1-2"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildOutlinedButton("2-3"),
              buildOutlinedButton("3-4"),
              buildOutlinedButton("4-5"),
              buildOutlinedButton("5-6"),
            ],
          ),
          SizedBox(
              width: 170,
              child: ElevatedButton(
                  child: Text("BOOK NOW"),
                  onPressed: () {
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "PAYMENT ALERT",
                      desc: "Please select your payment option.",
                      buttons: [
                        DialogButton(
                          child: Text(
                            " G pay",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          color: Color.fromRGBO(0, 179, 134, 1.0),
                        ),
                        DialogButton(
                          child: Text(
                            "PAYMENT",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(116, 116, 191, 1.0),
                            Color.fromRGBO(52, 138, 199, 1.0)
                          ]),
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

  InkWell buildOutlinedButton(
    String text,
  ) =>
      InkWell(
        onTap: (){
          setState(() {
            selectedbutton=button.Button;
            colorchanges=!colorchanges;

          });
        },
        child: OutlinedButton(
            onPressed: () {},
            child: Text(
              text,
              style:  TextStyle(fontSize: 20,
                color: selectedbutton==button.Button
                    ?Colors.lightGreen.shade600
                    :Colors.deepPurple,),
            )),
      );
}
