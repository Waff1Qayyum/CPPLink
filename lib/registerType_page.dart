import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controller.dart'; //comment

class RegisterTypePage extends StatefulWidget {
  const RegisterTypePage({super.key});

  @override
  State<RegisterTypePage> createState() => _RegisterTypePageState();
}

class _RegisterTypePageState extends State<RegisterTypePage> {
  bool isLoading = false;
  String? userType;
  double iconSize1 = 120;
  double iconSize2 = 120;
  late final StreamSubscription<AuthState>
      _authStateSubscription; //use to monitor any changes on auth
  var containerColor1 = Colors.white;
  var containerColor2 = Colors.white;
  void setUser(int y) {
    if (y == 1) {
      setState(() {
        containerColor1 = Color.fromRGBO(250, 195, 44, 1);
        containerColor2 = Colors.white;
        iconSize1 = 130;
        iconSize2 = 120;
        userType = 'rider';
      });
    } else if (y == 2) {
      setState(() {
        containerColor2 = Color.fromRGBO(250, 195, 44, 1);
        containerColor1 = Colors.white;
        iconSize1 = 120;
        iconSize2 = 130;
        userType = 'user';
      });
    }
  }

  void nextPage() {
    if (userType == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Select type of user')));
      return;
    } else if (userType == 'user') {
      RegisterUserType = 'user';
      print('user register');
    } else if (userType == 'rider') {
      RegisterUserType = 'rider';
      print('rider register');
    }
    print('go to register form');
    Navigator.of(context).pushReplacementNamed('/customer_registration');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 195, 44, 1),
        centerTitle: true,
        title: Text(
          'Register',
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
            Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
      ),
      body: Stack(children: [
        ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60.0,
                ),
                Container(
                  height: 42.0,
                  width: 235.0,
                  child: Container(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Register to',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Montagu Slab',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  )),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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

                ///Input Column
                Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(180, 221, 221,
                        221), // Semi-transparent black background
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(children: [
                        ///////////////
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'I am:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Select your type of user',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setUser(1);
                                },
                                child: Container(
                                  decoration: ShapeDecoration(
                                    color: containerColor1,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 0.50,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                        color: Color(0x38949494),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Column(children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // InkWell(
                                          //   onTap: () {
                                          //     Navigator.of(context)
                                          //         .pushReplacementNamed(
                                          //             '/rider_register');
                                          //   },
                                          //   child:
                                          Column(children: [
                                            Icon(
                                              Icons.delivery_dining_outlined,
                                              size: iconSize1,
                                            ),
                                            Text(
                                              'rider',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black.withOpacity(
                                                    0.3400000035762787),
                                                fontSize: 18,
                                                fontFamily: 'Lexend',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ]),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),

                              /////////////
////////////////////////////////////
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  setUser(2);
                                },
                                child: Container(
                                  decoration: ShapeDecoration(
                                    color: containerColor2,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 0.50,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                        color: Color(0x38949494),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Column(children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // InkWell(
                                          //   onTap: () {
                                          //     Navigator.of(context)
                                          //         .pushReplacementNamed(
                                          //             '/customer_register');
                                          //   },
                                          //   child:
                                          Column(children: [
                                            Icon(
                                              Icons.emoji_people,
                                              size: iconSize2,
                                            ),
                                            Text(
                                              'user',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black.withOpacity(
                                                    0.3400000035762787),
                                                fontSize: 18,
                                                fontFamily: 'Lexend',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ]),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                              /////////////
                            ]),
                        SizedBox(height: 40),
                        Container(
                          width: 263,
                          height: 37,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFFD233),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              nextPage();
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: Text(
                                isLoading == false ? 'Continue' : 'Loading..',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w700,
                                )),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFFFD233)),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),

                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Note :',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 1, 1, 1),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text('A User:',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 1, 1, 1),
                                    fontSize: 13,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text('1. Can request for parcel delivery service',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 1, 1, 1),
                                    fontSize: 13,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text('2. Can manage parcel',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 1, 1, 1),
                                    fontSize: 13,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                  )),
                              SizedBox(height: 10),
                              Text('A Rider:',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 1, 1, 1),
                                    fontSize: 13,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(
                                  '1. Can turn on delivery mode to provide a delivery service for customers',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 1, 1, 1),
                                    fontSize: 13,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text('2. Can access normal users\' features',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 1, 1, 1),
                                    fontSize: 13,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                  )),
                            ]),

                        ///////////////
                      ])),
                ),

                ///end
              ],
            ),
          ],
        ),
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
      ]),
    );
  }
}
