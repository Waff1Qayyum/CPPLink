import 'dart:async';

import 'package:cpplink/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class CustomerChangePicture extends StatefulWidget {
  const CustomerChangePicture({super.key});

  @override
  State<CustomerChangePicture> createState() => CustomerChangePictureState();
}

class CustomerChangePictureState extends State<CustomerChangePicture> {
  String? _imageUrl;
  bool _redirecting = false;
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session == null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/');
      }
    });
    super.initState();
    getImage();
  }

  Future<void> getImage() async {
    final userId = supabase.auth.currentUser!.id;
    final data =
        await supabase.from('user').select().eq('user_id', userId).single();
    setState(() {
      _imageUrl = data['profile_url'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 195, 44, 1),
        centerTitle: true,
        title: Text(
          'Update Profile',
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
            Navigator.of(context).pop();
          },
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
                  ),
                ),
              ],
            ),
          ),
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
                    ),
                  ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFFFFD233),
                              width: 1.0,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              './images/cat.jpeg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Muhd Aiman',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 22,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Color(0xFFFFD233),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '016240391',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Color(0xFFFFD233),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '@waffi1211@gmail.com',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w100,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                'Change Your Account\'s Profile Picture',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9B9B9B),
                  fontSize: 17,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Avatar(
                          imageUrl: _imageUrl,
                          onUpload: (imageUrl) async {
                            setState(() {
                              _imageUrl = imageUrl;
                            });
                            final userId = supabase.auth.currentUser!.id;
                            await supabase
                                .from('user')
                                .update({'picture_url': imageUrl}).match(
                                    {'user_id': userId});
                          },
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Enter your password for confirmation',
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
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              hintText: "enter a password ",
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 249, 249, 249),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
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
                                Icons.password,
                                color: Color(0xFFFFD233),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // Your code to handle the tap event
                              },
                              child: Container(
                                width: 135,
                                height: 53,
                                alignment: Alignment.center,
                                decoration: ShapeDecoration(
                                  color: const Color.fromARGB(255, 208, 24, 11),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      width: 1.50,
                                      color: Color.fromARGB(255, 208, 24, 11),
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
                                  'cancel',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 236, 236, 236),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            InkWell(
                              onTap: () {
                                // Your code to handle the tap event
                              },
                              child: Container(
                                width: 135,
                                height: 53,
                                alignment: Alignment.center,
                                decoration: ShapeDecoration(
                                  color: const Color.fromARGB(255, 44, 174, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
