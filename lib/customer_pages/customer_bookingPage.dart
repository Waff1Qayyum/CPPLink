import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../main.dart';

class customerBooking extends StatefulWidget {
  const customerBooking({super.key});

  @override
  State<customerBooking> createState() => customerBookingState();
}

class customerBookingState extends State<customerBooking> {
  TextEditingController _address = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool newBooking = true;
  List<String> selectedValues = [];

  Future<void> bookParcel() async {
    print(selectedValues);

    final userId = supabase.auth.currentUser!.id;
    final phone = await supabase
        .from('user')
        .select('phone')
        .eq('user_id', userId)
        .single();

    for (String s in selectedValues) {
      await supabase.from('booking').insert({
        'customer_id': userId,
        'parcel_id': s,
        'phone': phone['phone'],
        'address': _address.text,
      });
    }

    for (String s in selectedValues) {
      await supabase
          .from('parcel')
          .update({'status': 'waiting'}).eq('tracking_id', s);
    }

    await getData(userId);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 195, 44, 1),
        centerTitle: true,
        title: Text(
          'Booking Delivery',
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
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 390, // Adjusted width
                    height: 70, // Adjusted height
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(25), // Increased border radius
                      color: Colors.transparent,
                    ),
                    child: Stack(
                      children: [
                        // Inner shadow container
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                25), // Increased border radius
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Book Delivery',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 38,
                                  fontFamily: 'Montagu Slab',
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

                  SizedBox(
                    height: 10.0,
                  ),
                  /////////////////
                  ///////Dalam Kotak Kuning/////////
                  Container(
                    width: 390,
                    height: 450,
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align children to the left
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align children to the left
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '   Name',
                                                style: TextStyle(
                                                  color: Color(0xFF050505),
                                                  fontSize: 20,
                                                  fontFamily: 'Lexend',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0.00,
                                                ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: 350,
                                  height: 40,
                                  child: Text(
                                    user_name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      // You can add more text styling properties if needed
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 7),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Color(0xFF333333)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          /////////////////////////////////////////////////////////
                          ///////Phone Number ......
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align children to the left
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '   Phone Number',
                                                style: TextStyle(
                                                  color: Color(0xFF050505),
                                                  fontSize: 20,
                                                  fontFamily: 'Lexend',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0.00,
                                                ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: 350,
                                  height: 40,
                                  child: Text(
                                    user_phone,
                                    style: TextStyle(
                                      fontSize: 20,
                                      // You can add more text styling properties if needed
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 7),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Color(0xFF333333)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          /////////////////////////////////////////////////////////
                          ///////Tracking Number ......
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align children to the left
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '   Tracking Number',
                                                style: TextStyle(
                                                  color: Color(0xFF050505),
                                                  fontSize: 20,
                                                  fontFamily: 'Lexend',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0.00,
                                                ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                    width: 350,
                                    height: 40,
                                    // child: DropdownButtonHideUnderline(
                                    //   child: DropdownButton<String>(
                                    //     value: selectedValue,
                                    //     hint: Text('No parcel selected'),
                                    //     style: TextStyle(
                                    //       color: Color(0xFF050505),
                                    //       fontSize: 17,
                                    //       fontFamily: 'Lexend',
                                    //       fontWeight: FontWeight.w400,
                                    //       height: 0.00,
                                    //     ),
                                    //     onChanged: (String? newValue) {
                                    //       setState(() {
                                    //         selectedValue = newValue!;
                                    //       });
                                    //     },
                                    //     items: user_parcel
                                    //         .map<DropdownMenuItem<String>>(
                                    //             (String value) {
                                    //       return DropdownMenuItem<String>(
                                    //         value: value,
                                    //         child: Text(value),
                                    //       );
                                    //     }).toList(),
                                    //   ),
                                    // ),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2, color: Color(0xFF333333)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: MultiSelectDropDown(
                                      onOptionSelected: (options) {
                                        selectedValues = options
                                            .map((option) => option.value ?? "")
                                            .toList();
                                        print(selectedValues);
                                      },
                                      options: user_parcel
                                          .map((e) =>
                                              ValueItem(label: e, value: e))
                                          .toList(),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          /////////////////////////////////////////////////////////
                          ///////Address ......
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '   Address',
                                          style: TextStyle(
                                            color: Color(0xFF050505),
                                            fontSize: 20,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w400,
                                            height: 0.00,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            width: 350,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
////////////////////////////////
///////////////////////////////
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('Colleage : ',
                                                  style: TextStyle(
                                                    color: Color(0xFF050505),
                                                    fontSize: 20,
                                                    fontFamily: 'Lexend',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0.00,
                                                  )),
                                              InkWell(
                                                onTap: isLoading == true
                                                    ? null
                                                    : () async {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'select your Colleage :'),
                                                                insetPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                content: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KTDI'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KTHO'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KTR'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KDSE'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KDOJ'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KTC'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'K9'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'K10'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                    ]),
                                                              );
                                                            });
                                                      },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Container(
                                                    width:
                                                        130, // Adjust the width as needed
                                                    height: 40,
                                                    alignment: Alignment.center,
                                                    decoration: ShapeDecoration(
                                                      color: Colors.blue,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        side: BorderSide(
                                                          width: 1.50,
                                                          color: Colors
                                                              .blue, // Border color
                                                        ),
                                                      ),
                                                      shadows: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x3F000000),
                                                          blurRadius: 4,
                                                          offset: Offset(0, 4),
                                                          spreadRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    // if loading show indicator(optional)
                                                    child: isLoading == true
                                                        ? CircularProgressIndicator()
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.apartment,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      5), // Adjust the spacing as needed
                                                              Text(
                                                                'Colleage',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'Lexend',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                        //////////////////////
                                        SizedBox(height: 10),
                                        //////////////////////
                                        ///////////////
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('Block Number: ',
                                                  style: TextStyle(
                                                    color: Color(0xFF050505),
                                                    fontSize: 20,
                                                    fontFamily: 'Lexend',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0.00,
                                                  )),
                                              InkWell(
                                                onTap: isLoading == true
                                                    ? null
                                                    : () async {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'select your Block Number:'),
                                                                insetPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                content: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KTDI'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KTHO'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KTR'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KDSE'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KDOJ'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'KTC'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'K9'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                      ListTile(
                                                                        title: Text(
                                                                            'K10'),
                                                                        onTap:
                                                                            () {},
                                                                      ),
                                                                    ]),
                                                              );
                                                            });
                                                      },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Container(
                                                    width:
                                                        130, // Adjust the width as needed
                                                    height: 40,
                                                    alignment: Alignment.center,
                                                    decoration: ShapeDecoration(
                                                      color: Colors.blue,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        side: BorderSide(
                                                          width: 1.50,
                                                          color: Colors
                                                              .blue, // Border color
                                                        ),
                                                      ),
                                                      shadows: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x3F000000),
                                                          blurRadius: 4,
                                                          offset: Offset(0, 4),
                                                          spreadRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    // if loading show indicator(optional)
                                                    child: isLoading == true
                                                        ? CircularProgressIndicator()
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.home,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      5), // Adjust the spacing as needed
                                                              Text(
                                                                'Block',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'Lexend',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ]),
////////////////////////////////
///////////////////////////////
                                      ]),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 10),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 2, color: Color(0xFF333333)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ///////////////////////////////////////
                  /////////////////////////////////////
                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });

                      // Add your delete parcel logic here
                      print("Book Delivery tapped!");
                      // if (selectedValue == null) {
                      //   showDialog(
                      //       context: context,
                      //       builder: (context) => AlertDialog(
                      //             content:
                      //                 const Text('Please Select One Parcel'),
                      //             actions: [
                      //               TextButton(
                      //                   onPressed: () {
                      //                     Navigator.pop(context);
                      //                   },
                      //                   child: const Text('Understand')),
                      //             ],
                      //           ));
                      // }
                      if (_formKey.currentState!.validate()) {
                        // if (newBooking == true) {
                        await bookParcel();
                        isLoading = false;
                        Navigator.pushNamed(context, '/customer_myRider');
                        // } else {
                        //   print('cannot book');
                        //   setState(() {
                        //     isLoading = false;
                        //   });
                        //   showDialog(
                        //       context: context,
                        //       builder: (context) => AlertDialog(
                        //             actions: [
                        //               TextButton(
                        //                   onPressed: () {
                        //                     Navigator.of(context).pop();
                        //                   },
                        //                   child: Text('I understand'))
                        //             ],
                        //             title:
                        //                 Text('You can only request one parcel'),
                        //           ));
                        // }
                      }
                      setState(() {
                        isLoading = false;
                      });

                      // You can replace the print statement with the actual logic to delete the parcel.
                    },
                    child: Container(
                        width: 294,
                        // height: 36,
                        decoration: ShapeDecoration(
                          color: Color.fromARGB(255, 0, 207, 62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
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
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'BOOK N0W',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Lexend',
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
                        )),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              )
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
    );
  }
}
