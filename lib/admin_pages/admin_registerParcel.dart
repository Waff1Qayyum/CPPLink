import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class AdminRegisterParcel extends StatefulWidget {
  const AdminRegisterParcel({super.key});

  @override
  State<AdminRegisterParcel> createState() => _AdminRegisterParcelState();
}

class _AdminRegisterParcelState extends State<AdminRegisterParcel> {
  bool isLoading = false;
  bool? phoneValid;
  String? phone;
  TextEditingController _trackingNumber = TextEditingController();
  TextEditingController _customerName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime? current;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> registerParcel() async {
    current = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(current!);
    try {
      await supabase.from('parcel').insert({
        'tracking_id': _trackingNumber.text.toUpperCase(),
        'name': _customerName.text.toUpperCase(),
        'phone': phone,
        'date_arrived': formattedDate,
        'status': 'waiting',
      });
      print('register successfully!');
    } catch (error) {
      print('Error updating parcel: $error');
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
            'Register Parcel',
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
              Navigator.of(context).pushReplacementNamed('/admin_manageParcel');
            },
          ),
        ),
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(children: [
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: 220, // Adjusted width
                  height: 70, // Adjusted height
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(25), // Increased border radius
                    color: Colors.transparent,
                  ),
                  child: Stack(
                    children: [
                      // Background container
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: ShapeDecoration(
                          color: Color(0xFF0F0AF9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25), // Increased border radius
                          ),
                        ),
                      ),
                      // Inner shadow container
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              25), // Increased border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Register Parcel',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0.00,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////////
                ///////Dalam Kotak Kuning/////////
                Container(
                    width: 390,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFFD233),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(6, 5),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    ////////////////////////////////////////////////
                    ///Tracking Number.......
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 4, color: Color(0xFF333333)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Tracking Number',
                                                style: TextStyle(
                                                  color: Color(0xFF333333),
                                                  fontSize: 17,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0.00,
                                                ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Container(
                                  width: 230,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 4, color: Color(0xFF333333)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please fill in';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _trackingNumber,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .singleLineFormatter,
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "enter tracking number",
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
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        /////////////////////////////////////////////////
                        /////Name........
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 4, color: Color(0xFF333333)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Name',
                                                style: TextStyle(
                                                  color: Color(0xFF333333),
                                                  fontSize: 17,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0.00,
                                                ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Container(
                                  width: 230,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 4, color: Color(0xFF333333)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please fill in';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _customerName,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .singleLineFormatter,
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "enter customer name",
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
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(height: 10),
                        //////////////////////////////////////////////////////
                        ///Phone......
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(children: [
                            Container(
                              width: 100,
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 4, color: Color(0xFF333333)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Phone',
                                            style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 17,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 0.00,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              width: 230,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 4, color: Color(0xFF333333)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please fill in';
                                  } else if (phoneValid == false) {
                                    return 'Invalid Phone Number';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _phoneNumber,
                                textCapitalization:
                                    TextCapitalization.characters,
                                textAlignVertical: TextAlignVertical.center,
                                maxLines: 1,
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                decoration: InputDecoration(
                                  hintText: "enter mobile numbers",
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
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    )),

                /////////////////////////
                /////////////////////////
                SizedBox(
                  height: 30.0,
                ),
                /////////////////////////
                /////////////////////////
                InkWell(
                  onTap: isLoading == true
                      ? null
                      : () async {
                          // Your code to handle the tap event
                          setState(() {
                            isLoading = true;
                          });
                          phone = await formatPhone(_phoneNumber.text);
                          phoneValid = await phone_check(phone!);
                          if (_formKey.currentState!.validate()) {
                            await registerParcel();
                            //change snackbar design
                            await getParcelList();
                            Navigator.pushNamedAndRemoveUntil(context,
                                '/admin_manageParcel', (route) => false);
                          } else {
                            print('cannot register');
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                  child: Container(
                    width: 180,
                    height: 53,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: const Color.fromARGB(255, 44, 174, 48),
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
                    // if loading show indicator(optional)
                    child: isLoading == true
                        ? CircularProgressIndicator()
                        : Text(
                            'Confirm',
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
            ),
          ],
        ),
      ),
    );
  }
}
