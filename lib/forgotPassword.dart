import 'dart:async';

import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'main.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  bool? emailUnique;
  bool isLoading = false;

  Future<void> resetPassword() async {
    setState(() {
      isLoading = true;
    });
    final email = _emailController.text.trim();
    var emailExist = false;
    final checkAdmin = await supabase.from('admin').select().eq('email', email);
    final checkCustomer =
        await supabase.from('user').select().eq('email', email);

    if (checkAdmin.isNotEmpty || checkCustomer.isNotEmpty) {
      emailExist = true;
    }

    if (emailExist != true) {
      print("invalid email");
      setState(() {
        isLoading = true;
      });
      return;
    } else {
      try {
        supabase.auth.resetPasswordForEmail(
          email,
        );
        print('sent email successfully');
        setEmail(email);
        Navigator.of(context).pushReplacementNamed('/otpVerification');
      } on AuthException catch (error) {
        print('send password failed: ' + error.message);
      } catch (error) {
        print('unexpected error...');
      } finally {
        setState(() {
          isLoading = true;
        });
      }
    }
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
            'Forgot Password',
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
        ////////////////////////////
        body: Stack(children: [
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
                  // SizedBox(height: 20.0),
                  /////////////////////////////////////
                  /////////////////////////////////////
                  // SizedBox(height: 50),
                  // Text(
                  //   'RESET YOUR PASSWORD',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     // color: Color(0xFF9B9B9B),
                  //     color: Colors.black,

                  //     fontSize: 17,
                  //     fontFamily: 'Lexend',
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  ////////////////////////////////////
                  SizedBox(height: 40),

                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Text(
                              'Enter your email to reset password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            SizedBox(height: 20),

//////////////////////
                            Column(
                              children: [
                                Container(
                                  width: 263,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 0.5,
                                      color: Color.fromARGB(56, 25, 25, 25),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(164, 117, 117, 117),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: _emailController,
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .singleLineFormatter,
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "enter email",
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 249,
                                          249, 249), // Background color
                                      border: OutlineInputBorder(
                                        // Use OutlineInputBorder for rounded borders
                                        borderRadius: BorderRadius.circular(
                                            10), // This sets the rounded corners for the text field
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          width: 1.50,
                                          color: Color(0xFFFFD233),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 10),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Color(0xFFFFD233),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an email';
                                      } else if (emailUnique == false) {
                                        return 'Email Already Exist';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 70),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
//////////////////
                                  InkWell(
                                    onTap: () {
                                      resetPassword();
                                      // Your code to handle the tap event
                                    },
                                    child: Container(
                                      width: 263,
                                      height: 53,
                                      alignment: Alignment.center,
                                      decoration: ShapeDecoration(
                                        color: const Color.fromARGB(
                                            255, 44, 174, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                            width: 1.50,
                                            color: const Color.fromARGB(255, 44,
                                                174, 48), // Border color
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
                                        'confirm',
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
                                ])
                          ],
                        ),
//////////////////////////////

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
        ]),
      ),
    );
  }
}
