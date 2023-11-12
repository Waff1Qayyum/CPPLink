import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  String? name;
  String? phone;
  String? email;
  dynamic image;
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
    getName();
    getEmail();
    getPhone();
    displayImage();
  }

  Future<void> getName() async {
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('user')
        .select('name')
        .eq('user_id', userId)
        .single();
    if (mounted) {
      setState(() {
        name = data['name'];
      });
    }
  }

  Future<void> getPhone() async {
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('user')
        .select('phone')
        .eq('user_id', userId)
        .single();
    if (mounted) {
      setState(() {
        phone = data['phone'];
      });
    }
  }

  Future<void> getEmail() async {
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('user')
        .select('email')
        .eq('user_id', userId)
        .single();
    if (mounted) {
      setState(() {
        email = data['email'];
      });
    }
  }

  Future<void> displayImage() async {
    final userId = supabase.auth.currentUser!.id;
    final res = await supabase
        .from('user')
        .select('picture_url')
        .eq('user_id', userId)
        .single();

    if (res['picture_url'] == null) {
      return;
    }
    image = supabase.storage.from('picture').getPublicUrl('/$userId/profile');
    image = Uri.parse(image).replace(queryParameters: {
      't': DateTime.now().millisecondsSinceEpoch.toString()
    }).toString();

    setState(() {
      image = res['picture_url'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 195, 44, 1),
        centerTitle: true,
        title: Text(
          'Account information',
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
              Navigator.of(context).pushReplacementNamed('/customer_home');
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  //row to put the buttons
                  children: [
                    Padding(
                        //padding for all column
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                            //row to put image + name
                            children: [
                              Container(
                                width: 100, // Adjust the width as needed
                                height: 100, // Adjust the height as needed
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFFFFD233), // Border color
                                    width: 1.0, // Border width
                                  ),
                                ),
                                child: ClipOval(
                                    child: image != null
                                        ? Image.network(
                                            image!,
                                            fit: BoxFit.cover,
                                            width: 70,
                                            height: 70,
                                          )
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
                                      name ?? 'null',
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
                                          phone ?? 'null',
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
                                          email ?? 'null',
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
                                  ])
                            ])),
                  ]),
              SizedBox(height: 50),
              //Button
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(children: [
                      InkWell(
                        onTap: () {
                          // Your code to handle the tap event
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/changePFP', (route) => false);
                        },
                        child: Container(
                          width: 246,
                          height: 53,
                          alignment: Alignment.center,
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
                          child: Text(
                            'Change Profile Picture',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          // Your code to handle the tap event
                          Navigator.pushNamed(context, '/changeName');
                        },
                        child: Container(
                          width: 246,
                          height: 53,
                          alignment: Alignment.center,
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
                          child: Text(
                            'Change Name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          // Your code to handle the tap event
                          Navigator.of(context).pushNamed('/changePw');
                        },
                        child: Container(
                          width: 246,
                          height: 53,
                          alignment: Alignment.center,
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
                          child: Text(
                            'Change Password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          // Your code to handle the tap event
                          Navigator.of(context).pushNamed('/changePhone');
                        },
                        child: Container(
                          width: 246,
                          height: 53,
                          alignment: Alignment.center,
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
                          child: Text(
                            'Change Phone Number',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          // Your code to handle the tap event
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: const Text('Confirm Delete?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            await supabase.rpc('deleteUser');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Account Deleted Successfully')));
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/login',
                                                (route) => false);
                                          },
                                          child: const Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'))
                                    ],
                                  ));
                        },
                        child: Container(
                          width: 246,
                          height: 53,
                          alignment: Alignment.center,
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
                          child: Text(
                            'Delete Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ]),

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
    );
  }
}
