import '../controller.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class DeliveryList extends StatefulWidget {
  const DeliveryList({super.key});

  @override
  State<DeliveryList> createState() => _DeliveryListState();
}

class _DeliveryListState extends State<DeliveryList> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> selectParcel(int index) async {
    booking_index = index;
    Navigator.pushReplacementNamed(context, '/delivery_proof');
  }

  Future<void> cancelParcel(int index) async {
    booking_index = index;
    await supabase
        .from('booking')
        .update({'booking_status': 'cancelled', 'rider_id': null}).eq(
            'booking_id', rider_parcel_list[index]['booking_id']);

    await getRiderParcel(rider['rider_id']);
    await getRequestedParcelList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(248, 162, 41, 1),
          centerTitle: true,
          title: Text(
            'Deliveries',
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
            },
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 30),
                Text(
                  'My Deliveries',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 38,
                    fontFamily: 'Montagu Slab',
                    fontWeight: FontWeight.w400,
                    height: 0.00,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Deliveries: ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 17,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Text(
                      rider_parcel_list.length.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 17,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                /////////////////
////////////////////////////////////////

///////////////////////////////////////
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: rider_parcel_list.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 17,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 0.00,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Track Num. : ',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  Text(
                                    rider_parcel_list[index]['parcel']
                                        ['tracking_id'],
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Name : ',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  Text(
                                    rider_parcel_list[index]['parcel']['name'],
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Phone : ',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  Text(
                                    rider_parcel_list[index]['phone'],
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Address : ',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  Text(
                                    rider_parcel_list[index]['address'] ??
                                        'null',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                ],
                              ),
                              rider_parcel_list[index]['booking_status'] ==
                                      'accepted'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            cancelParcel(index);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 135,
                                                decoration: ShapeDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 174, 44, 44),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                      width: 1.50,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 174, 44, 44),
                                                    ),
                                                  ),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x3F000000),
                                                      blurRadius: 4,
                                                      offset: Offset(0, 4),
                                                      spreadRadius: 0,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Cancel',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              255, 255, 255),
                                                          fontSize: 15,
                                                          fontFamily: 'Lexend',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Delivery',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              255, 255, 255),
                                                          fontSize: 15,
                                                          fontFamily: 'Lexend',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            selectParcel(index);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 135,
                                                decoration: ShapeDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 44, 174, 48),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                      width: 1.50,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 44, 174, 48),
                                                    ),
                                                  ),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x3F000000),
                                                      blurRadius: 4,
                                                      offset: Offset(0, 4),
                                                      spreadRadius: 0,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    'Complete Delivery',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      fontSize: 15,
                                                      fontFamily: 'Lexend',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          'Status : ',
                                          style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: 17,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 0.00,
                                          ),
                                        ),
                                        Text(
                                          rider_parcel_list[index]
                                              ['booking_status'],
                                          style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: 17,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 0.00,
                                          ),
                                        )
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
