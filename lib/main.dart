
import 'package:flutter/material.dart';

import 'package:turf_booking_app/Design_pages/splash_screen.dart';

void main() async{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Splash());
  }
}
