import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';

class DeliveryProfilePage extends StatefulWidget {
  const DeliveryProfilePage({super.key});

  @override
  State<DeliveryProfilePage> createState() => _DeliveryProfilePageState();
}

class _DeliveryProfilePageState extends State<DeliveryProfilePage> {
  double totalIncome = 0;

  void getIncome() {
    for (var i in rider_parcel_list_delivered) {
      if (i['charge_fee'] != null) {
        totalIncome += i['charge_fee'];
      }
    }
  }

  @override
  void initState() {
    getIncome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(248, 134, 41, 1),
        centerTitle: true,
        title: Text(
          'Rider Profile',
          style: TextStyle(
            fontFamily: 'roboto',
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, // You can replace this with your custom logo
            color: Colors.white, // Icon color
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/delivery_homepage');
            // Your code to handle the tap event
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              SizedBox(height: 40.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //row to put the buttons
                  children: [
                    Padding(
                        //padding for all column
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                            //row to put image + name
                            children: [
                              Container(
                                width: 100, // Adjust the width as needed
                                height: 100, // Adjust the height as needed
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color.fromRGBO(
                                        248, 134, 41, 1), // Border color
                                    width: 1.0, // Border width
                                  ),
                                ),
                                child: ClipOval(
                                    child: user_picture != null
                                        ? picture!
                                        : Container(
                                            color: Colors.grey,
                                          )),
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user_name ?? 'Loading...',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 22,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color:
                                              Color.fromRGBO(248, 134, 41, 1),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          user_phone ?? 'Loading...',
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 15,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w100,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color:
                                              Color.fromRGBO(248, 134, 41, 1),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          user_email ?? 'Loading...',
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 15,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w100,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ])
                            ])),
                  ]),
              SizedBox(height: 50),
              //Button
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(children: [
                      Column(
                        children: [
                          Text(
                            'Total Deliveries :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                              height: 0.00,
                            ),
                          ),
                          Text(
                            rider_parcel_list_delivered.length.toString(),
                            style: TextStyle(
                              color: Color.fromRGBO(248, 134, 41, 1),
                              fontSize: 50,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                              height: 0.00,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Column(
                        children: [
                          Text(
                            'Total Income :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                              height: 0.00,
                            ),
                          ),
                          Text(
                            totalIncome.toStringAsFixed(2),
                            style: TextStyle(
                              color: Color.fromRGBO(248, 134, 41, 1),
                              fontSize: 50,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                              height: 0.00,
                            ),
                          ),
                        ],
                      ),
                    ]),

                    ///////////////////////////
                  ),
                ],
                // ],
              ),

              ///end
            ],
          ),
        ],
      ),
    );
  }
}
