import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking_app/Design_pages/admin_page.dart';
import 'package:turf_booking_app/Design_pages/login_page.dart';
import 'package:turf_booking_app/Design_pages/user_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  late var role ;
  var user=2;
  var admin =1;

  late SharedPreferences localStorsge;

  Future<void>checkRole()async{
    localStorsge=await SharedPreferences.getInstance();
    role=(localStorsge.getInt('userRole') ?? 0);
    print("role$role");
    if(role==user){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserPart()));
    }else if(role==admin){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Admin()));

    }
    else{
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Login()));

    }
  }

  void initState() {
    super.initState();
    startTime();
  }

  startTime()async{
    var duration=new Duration(seconds: 3);
    return Timer(duration,checkRole);
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Login()

            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/turf images2.jpg"),
                  fit: BoxFit.fill,

                ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("LET THE WORLD",style: TextStyle(
                  fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold
                ),),
                Text("PLAY",style: TextStyle(fontSize: 30,color:
                Colors.red,fontWeight: FontWeight.bold),)
              ],
            ),

          )
        ],
      ),
    );
  }
}
