import 'package:flutter/material.dart';

class DeliveryList extends StatefulWidget {
  const DeliveryList({super.key});

  @override
  State<DeliveryList> createState() => _DeliveryListState();
}

class _DeliveryListState extends State<DeliveryList> {
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
                Text(
                  'Total Deliveries: 2',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 17,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                SizedBox(height: 20),
                /////////////////
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/delivery_proof');
                    },
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /////////////
                                ////////////
                                Text(
                                  '1.',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 17,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0.00,
                                  ),
                                ),
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
                                  'Name : ',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 17,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0.00,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Address :',
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
                            SizedBox(width: 10),
                            // Adjust the spacing between columns
                            // Right column with data
                            Expanded(
                              // child: SingleChildScrollView(
                              //   scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Fetch and display data from the database here
                                  // Example:
                                  SizedBox(height: 20),
                                  Text(
                                    'EFX33290', // Replace with actual data
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  Text(
                                    'MUHAMMAD WAFFI QAYYUM BIN DIN', // Replace with actual data
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                  Text(
                                    'MA1, KTDI', // Replace with actual data
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                      width: 135,
                                      // height: 53,
                                      alignment: Alignment.center,
                                      decoration: ShapeDecoration(
                                        color: const Color.fromARGB(
                                            255, 44, 174, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                            width: 1.50,
                                            color: const Color.fromARGB(
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
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 15,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
////////////////////////////////////////
                SizedBox(height: 20),
///////////////////////////////////////
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/delivery_proof');
                    },
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /////////////
                                ////////////
                                Text(
                                  '2.',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 17,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0.00,
                                  ),
                                ),
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
                                  'Name : ',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 17,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0.00,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Address :',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 17,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0.00,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            // Adjust the spacing between columns
                            // Right column with data
                            Expanded(
                              // child: SingleChildScrollView(
                              //   scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Fetch and display data from the database here
                                  // Example:
                                  SizedBox(height: 20),
                                  Text(
                                    'EFX33290', // Replace with actual data
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  Text(
                                    'MUHAMMAD WAFFI QAYYUM BIN DIN', // Replace with actual data
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                  Text(
                                    'MA1, KTDI', // Replace with actual data
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                      width: 135,
                                      // height: 53,
                                      alignment: Alignment.center,
                                      decoration: ShapeDecoration(
                                        color: const Color.fromARGB(
                                            255, 44, 174, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                            width: 1.50,
                                            color: const Color.fromARGB(
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
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 15,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
