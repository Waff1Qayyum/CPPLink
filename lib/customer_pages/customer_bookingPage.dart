import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class customerBooking extends StatefulWidget {
  const customerBooking({super.key});

  @override
  State<customerBooking> createState() => customerBbookingState();
}

class customerBbookingState extends State<customerBooking> {
  String? selectedValue;
  dynamic dropDownItem;

  void getTrackingId(String name) async {
    final parcel =
        await supabase.from('parcel').select('tracking_id').eq('name', name);

    setState(() {
      dropDownItem = parcel;
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
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 390, // Adjusted width
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align children to the left
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
                            child: Text(user_name),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
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
                            child: Text(user_phone),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
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
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                                items: user_parcel
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
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
                    ///////Address ......
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
                            height: 140,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
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
                  ],
                ),
              ),
              ///////////////////////////////////////
              /////////////////////////////////////
              SizedBox(
                height: 50.0,
              ),
              GestureDetector(
                onTap: () {
                  // Add your delete parcel logic here
                  print("Book Delivery tapped!");
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
    );
  }
}
