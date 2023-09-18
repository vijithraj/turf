import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turf_booking_app/Design_pages/home_page.dart';

class UserPart extends StatefulWidget {
  const UserPart({Key? key}) : super(key: key);

  @override
  State<UserPart> createState() => _UserPartState();
}

class _UserPartState extends State<UserPart> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              height: 690,
              width: screenWidth,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.home,
                          size: 35,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Home Page",
                          style: TextStyle(
                              fontSize: 24, color: Colors.indigoAccent),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(30)),
                      height: 150,
                      width: screenWidth,
                      child: const Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("LIFE IS LIKE ",style:
                            TextStyle(fontSize: 25,color: Colors.amber),),
                          Text (" SOCCER",style:
                          TextStyle(fontSize: 25,color: Colors.amber),),
                          Text (" YOU NEED GOALS !",style:
                          TextStyle(fontSize: 25,color: Colors.amber),)
                        ],
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            height: 15,
                            thickness: 2,
                            indent: 0,
                            endIndent: 5,
                            color: Colors.indigoAccent,
                          ),
                        ),
                      ),
                      Text(
                        "Some other features",
                        style: TextStyle(fontSize: 15, color: Colors.indigo),
                      ),
                      Expanded(
                        child: Divider(
                          height: 15,
                          thickness: 2,
                          indent: 20,
                          endIndent: 5,
                          color: Colors.indigoAccent,
                        ),
                      ),
                    ],
                  ),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, crossAxisSpacing: 10),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          },
                          child: Container(
                            /*alignment: Alignment.center,*/
                            margin: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "TURF",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.amber),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "BOOKING",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.amber),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(30)),
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "VIEW ALL ",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.amber),
                                ),
                                Text(
                                  "TURF",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.amber),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(30)),
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "VIEW",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.amber),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "PAYMENTS",
                                    style: TextStyle(
                                        fontSize: 23, color: Colors.amber),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(30)),
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  " VIEW ",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.amber),
                                ),
                                Text(
                                  " BOOK ",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.amber),
                                ),
                                Text(
                                  "TURF",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.amber),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
