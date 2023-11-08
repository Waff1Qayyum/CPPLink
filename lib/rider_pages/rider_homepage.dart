import 'package:flutter/material.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({super.key});

  @override
  State<RiderHomePage> createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(250, 195, 44, 1),
          centerTitle: true,
          title: Text(
            'Rider Homepage',
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
                          // Implement sign out logic here
                        },
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Color(0xFFFF0000),
                            fontSize: 13,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w800,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: Image.asset(
                      './images/cpp_logo.png',
                      width: 70,
                      height: 70,
                    )),
                    Text(
                      'CPP',
                      style: TextStyle(
                        color: Color(0xFF050505),
                        fontSize: 48,
                        fontFamily: 'Montagu Slab',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Text(
                      'Link',
                      style: TextStyle(
                        color: Color(0xFFFFD233),
                        fontSize: 32,
                        fontFamily: 'Montagu Slab',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                Row(
                    //row to put the image+name and notification icon
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          //padding for all column
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
                                        color:
                                            Color(0xFFFFD233), // Border color
                                        width: 1.0, // Border width
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        './images/cpp_logo.png', // Replace with your image URL
                                        width: 50, // Adjust the width as needed
                                        height:
                                            50, // Adjust the height as needed
                                        fit: BoxFit
                                            .cover, // Adjust the fit as needed
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          'Muhd Aiman',
                                          style: TextStyle(
                                            color: Color(0xFFFFD233),
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
                SizedBox(height: 70),
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
                                    Icons.delivery_dining_outlined,
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
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
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
                                  Icons.drive_file_rename_outline,
                                  size: 50, // Adjust the size as needed
                                  color: const Color.fromARGB(255, 255, 255,
                                      255), // Change the icon color
                                ),
                                Text(
                                  'Write Feedback',
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