import 'dart:async';
import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'main.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => OTPVerificationState();
}

class OTPVerificationState extends State<OTPVerification> {
  TextEditingController _otpController = TextEditingController();

  confirmOTP() async {
    var session = await supabase.auth.currentSession;
    var userEmail = getEmail();

    final otpToken = _otpController.text;
    try {
      await supabase.auth
          .verifyOTP(email: userEmail, token: otpToken, type: OtpType.recovery);
      print('OTP verification success');
      Navigator.of(context).pushReplacementNamed('/resetPassword');
    } on AuthException catch (error) {
      print('OTP verification error : ' + error.message);
    } catch (error) {
      print('unexpected error...');
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
            'Reset password',
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
                /////////////////////////////////////
                /////////////////////////////////////
                SizedBox(height: 50),
                Text(
                  'OTP Verification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF9B9B9B),
                    fontSize: 17,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ////////////////////////////////////
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Text(
                            'Enter the OTP sent to you by email',
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

//////////////////////
                          Column(
                            children: [
                              Container(
                                width: 263,
                                height: 37,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Color.fromARGB(56, 25, 25, 25),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(164, 117, 117, 117),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: _otpController,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    hintText: "enter otp",
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 249, 249, 249), // Background color
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
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Color(0xFFFFD233),
                                    ),
                                  ),
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
                                    confirmOTP();
                                    // Your code to handle the tap event
                                  },
                                  child: Container(
                                    width: 135,
                                    height: 53,
                                    alignment: Alignment.center,
                                    decoration: ShapeDecoration(
                                      color: const Color.fromARGB(
                                          255, 44, 174, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          width: 1.50,
                                          color: const Color.fromARGB(
                                              255, 44, 174, 48), // Border color
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
      ),
    );
  }
}
