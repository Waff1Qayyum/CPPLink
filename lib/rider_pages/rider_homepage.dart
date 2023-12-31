import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controller.dart';
import '../main.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({super.key});

  @override
  State<RiderHomePage> createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage> {
  void riderModeActive() async {
    setState(() {
      riderMode = true;
    });
    await getRequestedParcelList();
    await getRiderParcel(user_rider[0]['rider_id']);
    await updateRiderStatus(user_rider[0]['rider_id'], 'idle');

    Navigator.pushNamedAndRemoveUntil(
        context, '/delivery_homepage', (route) => false);
  }

  void riderDeliveryMode() async {
    setState(() {
      riderMode = true;
    });
    await getRequestedParcelList();
    await getRiderParcel(user_rider[0]['rider_id']);
    updateRiderStatus(user_rider[0]['rider_id'], 'delivering');
    Navigator.pushNamedAndRemoveUntil(
        context, '/delivery_homepage', (route) => false);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   print(supabase.auth.currentUser!.id);
  //   print(user_rider[0]['user_id']);

  //   print(user_rider[0]['rider_id']);
  //   print(user_rider[0]['status']);

  //   print(isDeliver);
  //   // getRiderStatus();
  //   // if (isDeliver == true) {
  //   //   riderMode = true;
  //   //   riderDeliveryMode();
  //   // } else
  //   if (user_rider[0]['rider_id'] != null &&
  //       user_rider[0]['status'] == "offline") {
  //     riderMode = false;
  //   } else {
  //     riderMode = true;
  //     riderModeActive();
  //   }
  // }

  Future<void> _showConfirmationDialog(bool newValue) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Switch ON to Rider Mode?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog without updating the riderMode value
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog and update the riderMode value
                Navigator.of(context).pop();
                setState(() {
                  riderModeActive();
                });
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

/////////////////////////
////////////////////////
  updateData() async {
    await getRiderDetail(currentUserID);
    await checkBookingStatus(currentUserID);
    if (mounted) {
      setState(() {
        rider_exist;
        show_row;
        delivered;
        vehicle_picture;
        vehicle_url;
        rider_name;
        rider_vehicleType;
        rider_plate;
        rider_model;
        rider_color;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (user_rider[0]['rider_id'] != null &&
        user_rider[0]['status'] == "offline") {
      riderMode = false;
    } else {
      riderMode = true;
      riderModeActive();
    }

    if (mounted) {
      //listen to realtime changes on database
      supabase
          .channel('public:customer')
          .onPostgresChanges(
              event: PostgresChangeEvent.all,
              schema: 'public',
              table: 'booking',
              callback: (payload) {
                print('Change received: ${payload.toString()}');
                updateData();
              })
          .subscribe();
    }
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
                // SizedBox(
                //   height: 20.0,
                // ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rider Mode :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          // SizedBox(height: 20),
                          Switch(
                            value: riderMode,
                            onChanged: (value) async {
                              // Show the confirmation dialog before changing the riderMode value
                              await _showConfirmationDialog(value);
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        child: user_picture != null
                                            ? picture!
                                            : Container(
                                                color: Colors.grey,
                                              )),
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
                                          user_name ?? 'Loading..',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 7, 7, 131),
                                            fontSize: 22,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                      ])
                                ]),
                              ])),
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
                                    .pushNamed('/rider_myRider');
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
                    : SizedBox(height: 40),

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
                                  .pushReplacementNamed('/rider_booking');
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
                              Navigator.of(context)
                                  .pushReplacementNamed('/rider_checkParcel');
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
                                .pushReplacementNamed('/rider_profile');
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
                                .pushReplacementNamed('/rider_quickScan');
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
