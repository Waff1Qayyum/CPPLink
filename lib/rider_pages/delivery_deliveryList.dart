import 'package:flutter/material.dart';

import '../controller.dart';
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
            'booking_id',
            rider_parcel_list_ongoing[booking_index]['booking_id']);

    await getRiderParcel(rider['rider_id']);
    await getRequestedParcelList();
    await updateRiderStatus(currentUserID, "idle");
    setState(() {});
  }

  goToViewPage() {
    Navigator.pushReplacementNamed(context, '/delivery_qrPage');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(248, 134, 41, 1),
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
            SingleChildScrollView(
              child: Column(
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
                        // rider_parcel_list.length.toString(),
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 20,
                    child: Text(
                      'Ongoing',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.00,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: rider_parcel_list_ongoing.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 40, left: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(62, 229, 188, 188),
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
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    // children: [
                                    //   for (var i
                                    //       in rider_parcel_list_ongoing[index]
                                    //           ['booking_parcel'])
                                    //     if (i['parcel']['status'] != 'delivered')
                                    //       QrImageView(
                                    //         data: i['parcel_id'],
                                    //         version: QrVersions.auto,
                                    //         size: 100.0,
                                    //       ),
                                    // ],
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          updateCurrentBookingList(
                                              rider_parcel_list_ongoing[index]
                                                  ['booking_parcel']);
                                          goToViewPage();
                                          //           ['booking_parcel']);
                                        },
                                        child: Text(
                                          'View Parcel Qr Code : ',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 17,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 0.00,
                                          ),
                                        ),
                                      )
                                    ]),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
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
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        // for (var i in rider_parcel_list_ongoing[index].value)
                                        Text(
                                          rider_parcel_list_ongoing[index]
                                                  ['booking_parcel']
                                              .map((i) => i['parcel_id'])
                                              .join(', \n'),
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
                                      rider_parcel_list_ongoing[index]
                                              ['booking_parcel'][0]['parcel']
                                          ['name'],
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
                                      rider_parcel_list_ongoing[index]['phone'],
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
                                      rider_parcel_list_ongoing[index]
                                              ['address'] ??
                                          'MA1,KTDI',
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
                                SizedBox(height: 10),
                                rider_parcel_list_ongoing[index]
                                            ['booking_status'] ==
                                        'accepted'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                                  width: 100,
                                                  height: 50,
                                                  decoration: ShapeDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 174, 44, 44),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                        width: 1.50,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 174, 44, 44),
                                                      ),
                                                    ),
                                                    shadows: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x3F000000),
                                                        blurRadius: 4,
                                                        offset: Offset(0, 4),
                                                        spreadRadius: 0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Center(
                                                        child: Text(
                                                          'Cancel',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                255, 255, 255),
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'Lexend',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      )),
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
                                                  width: 100,
                                                  height: 50,
                                                  decoration: ShapeDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 44, 174, 48),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                        width: 1.50,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 44, 174, 48),
                                                      ),
                                                    ),
                                                    shadows: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x3F000000),
                                                        blurRadius: 4,
                                                        offset: Offset(0, 4),
                                                        spreadRadius: 0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Center(
                                                      child: Text(
                                                        'Complete',
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
                                            rider_parcel_list_ongoing[index]
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
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'Delivered',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.00,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: rider_parcel_list_delivered.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(right: 40, left: 40, bottom: 10),
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
                                // Row(
                                //     // mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       InkWell(
                                //         onTap: () {
                                //           updateCurrentBookingList(
                                //               rider_parcel_list_delivered[index]
                                //                   ['booking_parcel']);
                                //           //           );
                                //           goToViewPage();
                                //           //           ['booking_parcel']);
                                //         },
                                //         child: Text(
                                //           'View Parcel Qr Code : ',
                                //           style: TextStyle(
                                //             color: Colors.blue,
                                //             fontSize: 17,
                                //             fontFamily: 'Roboto',
                                //             fontWeight: FontWeight.w400,
                                //             height: 0.00,
                                //           ),
                                //         ),
                                //       )
                                //     ]
                                //     // children: [
                                //     //   for (var i
                                //     //       in rider_parcel_list_delivered[index]
                                //     //           ['booking_parcel'])
                                //     //     if (i['parcel']['status'] != 'delivered')
                                //     //       QrImageView(
                                //     //         data: i['parcel_id'],
                                //     //         version: QrVersions.auto,
                                //     //         size: 100.0,
                                //     //       ),
                                //     // ],
                                //     ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
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
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        // for (var i in rider_parcel_list_delivered[index].value)
                                        Text(
                                          rider_parcel_list_delivered[index]
                                                  ['booking_parcel']
                                              .map((i) => i['parcel_id'])
                                              .join(',\n'),
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
                                      rider_parcel_list_delivered[index]
                                              ['booking_parcel'][0]['parcel']
                                          ['name'],
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
                                      rider_parcel_list_delivered[index]
                                          ['phone'],
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
                                      rider_parcel_list_delivered[index]
                                              ['address'] ??
                                          'MA1,KTDI',
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
                                SizedBox(height: 10),
                                rider_parcel_list_delivered[index]
                                            ['booking_status'] ==
                                        'accepted'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                                  width: 100,
                                                  height: 50,
                                                  decoration: ShapeDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 174, 44, 44),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                        width: 1.50,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 174, 44, 44),
                                                      ),
                                                    ),
                                                    shadows: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x3F000000),
                                                        blurRadius: 4,
                                                        offset: Offset(0, 4),
                                                        spreadRadius: 0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Center(
                                                        child: Text(
                                                          'Cancel',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                255, 255, 255),
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'Lexend',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      )),
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
                                                  width: 100,
                                                  height: 50,
                                                  decoration: ShapeDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 44, 174, 48),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                        width: 1.50,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 44, 174, 48),
                                                      ),
                                                    ),
                                                    shadows: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x3F000000),
                                                        blurRadius: 4,
                                                        offset: Offset(0, 4),
                                                        spreadRadius: 0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Center(
                                                      child: Text(
                                                        'Complete',
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
                                            rider_parcel_list_delivered[index]
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
            ),
          ],
        ),
      ),
    );
  }
}
