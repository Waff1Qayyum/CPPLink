import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminHomePage> {
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
  }
  
  ElevatedButton buildElevatedButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }
            return Color.fromARGB(255, 255, 211, 51);
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(width: 1),
          ),
        ),
      ),
      child: Container(
        width: 155,
        height: 129,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.40,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(250, 195, 44, 1),
          centerTitle: true,
          flexibleSpace: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Admin Homepage',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: 'Montagu Slab',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {
                          supabase.auth.signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF1720ED),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: Size(75, 30),
                  ),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                  children: [
                    Container(
                      color: Colors.blue,
                      width: 151,
                      height: 150,
                      child: Image.asset('./images/cpp_logo.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    buildElevatedButton(
                      label: 'Parcel Management',
                      onPressed: () {
                        // Define the action to be executed when the button is pressed.
                      },
                    ),
                    SizedBox(width: 35.0),
                    buildElevatedButton(
                      label: 'Rider Management',
                      onPressed: () {
                        // Define the action to be executed when the button is pressed.
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [
                    buildElevatedButton(
                      label: 'View Feedback',
                      onPressed: () {
                        // Define the action to be executed when the button is pressed.
                      },
                    ),
                    SizedBox(width: 35.0),
                    buildElevatedButton(
                      label: 'View Customers Details',
                      onPressed: () {
                        // Define the action to be executed when the button is pressed.
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
