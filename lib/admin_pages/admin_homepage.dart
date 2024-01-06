import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(250, 195, 44, 1),
          centerTitle: true,
          title: Text(
            'Admin Homepage',
            style: TextStyle(
              fontFamily: 'Montagu Slab',
              fontWeight: FontWeight.bold,
              fontSize: 18,
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
                          if (mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false);
                          }
                          supabase.auth.signOut();
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
        body: Stack(
          children: [
            ListView(
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
                    SizedBox(height: 60.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(

                          //row to put the image+name and notification icon
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                //padding for all column
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                    //row to put image + name
                                    children: [
                                      Row(children: [
                                        Container(
                                          width:
                                              50, // Adjust the width as needed
                                          height:
                                              50, // Adjust the height as needed
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 215, 172, 15),
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                            border: Border.all(
                                              color: Color(
                                                  0xFFFFD233), // Border color
                                              width: 1.0, // Border width
                                            ),
                                          ),
                                          child: ClipOval(
                                              child: picture_url != null
                                                  ? admin_picture
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
                                              Container(
                                                child: Text(
                                                  admin_name ?? 'Loading..',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 7, 131),
                                                    fontSize: 22,
                                                    fontFamily: 'Lexend',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ])
                                      ]),
                                    ])),
                          ]),
                    ),
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
                                  try {
                                    Navigator.of(context).pushReplacementNamed(
                                        '/admin_quickFind');
                                  } on Exception catch (e) {
                                    print(e.toString());
                                  }
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
                                        color:
                                            Color(0xFFFFD233), // Border color
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
                                        color: const Color.fromARGB(255, 255,
                                            255, 255), // Change the icon color
                                      ),
                                      Text(
                                        'Quick Find',
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
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await getParcelList();
                                  Navigator.of(context).pushReplacementNamed(
                                      '/admin_manageParcel');
                                  setState(() {
                                    isLoading = false;
                                  });
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
                                        color:
                                            Color(0xFFFFD233), // Border color
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
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.widgets,
                                        size: 50, // Adjust the size as needed
                                        color: Color.fromARGB(255, 255, 255,
                                            255), // Change the icon color
                                      ),
                                      Text(
                                        'Manage Parcel',
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
                                    .pushReplacementNamed('/admin_profile');
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
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await getAllRiderParcel();
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.of(context)
                                    .pushReplacementNamed('/admin_manageRider');

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
                                      'Monitor Rider',
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
            // Loading indicator overlay
            if (isLoading)
              Container(
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LottieBuilder.asset('assets/yellow_loading.json'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
