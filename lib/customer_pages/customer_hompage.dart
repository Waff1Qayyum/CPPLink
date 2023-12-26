import 'package:flutter/material.dart';

import '../controller.dart';
import '../main.dart';

class CustomerHomepage extends StatefulWidget {
  const CustomerHomepage({super.key});

  @override
  State<CustomerHomepage> createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {
  bool shouldShowRow = false;
  String userId = supabase.auth.currentUser!.id;
  String request_status = "no request";

  @override
  void initState() {
    super.initState();
    // checkBookingStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(250, 195, 44, 1),
          centerTitle: true,
          title: Text(
            'Customer Homepage',
            style: TextStyle(
              fontFamily: 'roboto',
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          supabase.auth.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        },
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Color(0xFFFF0000),
                            fontSize: 13,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        )),
                  ],
                )),
          ],
        ),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    Container(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.,
                        children: [
                          Text(
                            'CPP',
                            style: TextStyle(
                              color: Color.fromRGBO(250, 195, 44, 1),
                              fontSize: 48,
                              fontFamily: 'Montagu Slab',
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 145, 145, 145),
                                  offset: Offset(0, 3),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Link',
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 7, 131),
                              fontSize: 32,
                              fontFamily: 'Montagu Slab',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                          //row to put image + name
                          children: [
                            Row(children: [
                              Container(
                                width: 50, // Adjust the width as needed
                                height: 50, // Adjust the height as needed
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFFFFD233), // Border color
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
                                      'Welcome back, ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      user_name ?? 'Loading..',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 7, 7, 131),
                                        fontSize: 22,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                  ])
                            ]),
                          ])),
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.notifications, color: Colors.black),
                    onPressed: () {
                      // Add your action here
                    },
                  ),
                ]),
                /////////////////////////////////
                show_row
                    ? Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // Your code to handle the tap event
                                Navigator.of(context)
                                    .pushNamed('/customer_myRider');
                              },
                              child: Container(
                                width: 246,
                                height: 53,
                                alignment: Alignment.center,
                                decoration: ShapeDecoration(
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      width: 1.50,
                                      color: Colors.green, // Border color
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
                                child: Text(
                                  'My Booking',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(height: 70),

                //////////////////////////////
                /////////////////////////////
                Text(
                  'What would you want to do for Today ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF9B9B9B),
                    fontSize: 17,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, //book and check parcel button
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/customer_booking');
                            },
                            child: Container(
                              width: 155,
                              height: 129,
                              decoration: ShapeDecoration(
                                color: Color(0xFFFFD233),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    width: 1.50,
                                    color: Color(0xFFFFD233), // Border color
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.delivery_dining_outlined,
                                    size: 50, // Adjust the size as needed
                                    color: const Color.fromARGB(255, 255, 255,
                                        255), // Change the icon color
                                  ),
                                  Text(
                                    'Book Delivery',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              await getParcelList();
                              Navigator.of(context).pushReplacementNamed(
                                  '/customer_checkParcel');
                              // Your code to handle the tap event
                            },
                            child: Container(
                              width: 155,
                              height: 129,
                              decoration: ShapeDecoration(
                                color: Color(0xFFFFD233),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    width: 1.50,
                                    color: Color(0xFFFFD233), // Border color
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.widgets,
                                    size: 50, // Adjust the size as needed
                                    color: const Color.fromARGB(255, 255, 255,
                                        255), // Change the icon color
                                  ),
                                  Text(
                                    'Check Parcel',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                    ///////////////////////////
                  ],
                ),
                /////////////////////////first row for book and check parcel
                SizedBox(
                  height: 30,
                ),
                /////////////////////////second row for update and feedback buttons
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, //book and check parcel button
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/customer_profile');
                            // Your code to handle the tap event
                          },
                          child: Container(
                            width: 155,
                            height: 129,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFFD233),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  width: 1.50,
                                  color: Color(0xFFFFD233), // Border color
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.manage_accounts,
                                  size: 50, // Adjust the size as needed
                                  color: const Color.fromARGB(255, 255, 255,
                                      255), // Change the icon color
                                ),
                                Text(
                                  'Update Profile',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/customer_quickScan');
                            // Your code to handle the tap event
                          },
                          child: Container(
                            width: 155,
                            height: 129,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFFD233),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  width: 1.50,
                                  color: Color(0xFFFFD233), // Border color
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.qr_code_scanner,
                                  size: 50, // Adjust the size as needed
                                  color: const Color.fromARGB(255, 255, 255,
                                      255), // Change the icon color
                                ),
                                Text(
                                  'Quick scan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                ])

                ///end
              ],
            ),
          ],
        ),
      ),
    );
  }
}
