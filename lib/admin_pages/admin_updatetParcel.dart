import 'package:flutter/material.dart';

class AdminUpdateParcel extends StatefulWidget {
  const AdminUpdateParcel({super.key});

  @override
  State<AdminUpdateParcel> createState() => _AdminUpdateParcelState();
}

class _AdminUpdateParcelState extends State<AdminUpdateParcel> {
  String selectedPaymentStatus = 'not paid';
  String selectedDeliveryStatus = 'on delivery';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(250, 195, 44, 1),
          centerTitle: true,
          title: Text(
            'Update Parcel',
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
              Navigator.pushNamedAndRemoveUntil(
                  context, '/admin_home', (route) => false);
            },
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
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
                              'Edit Parcel',
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
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(children: [
                            Container(
                              width: 120,
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                                              fontSize: 20,
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
                              width: 210,
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 4, color: Color(0xFF333333)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            )
                          ]),
                        ),
                        /////////////////////////////////////////////////
                        /////Name........
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(children: [
                            Container(
                              width: 110,
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
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
                                              fontSize: 20,
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
                            Expanded(
                                child: Container(
                              width: 220,
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 4, color: Color(0xFF333333)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            )),
                          ]),
                        ),
                        SizedBox(height: 10),
                        //////////////////////////////////////////////////////
                        ///Phone......
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(children: [
                            Container(
                              width: 110,
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
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Phone',
                                            style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 20,
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
                              width: 220,
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 4, color: Color(0xFF333333)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            )
                          ]),
                        ),
                        /////////////////////////////////////////////////////
                        ///Date Arrive.....
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(children: [
                            Container(
                              width: 120,
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
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Date Arrive',
                                            style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 20,
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
                              width: 180,
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 4, color: Color(0xFF333333)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            )
                          ]),
                        ),
                        //////////////////////////////////////////////////////
                        ///Payment Status..........
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Container(
                                width: 120,
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
                                child: Center(
                                  child: Text(
                                    'Payment Status',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 20,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Container(
                                width: 160,
                                height: 60,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
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
                                      child: DropdownButton<String>(
                                        value: selectedPaymentStatus,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedPaymentStatus = newValue!;
                                          });
                                        },
                                        items: <String>['paid', 'not paid']
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ///////////////////////////////////////////////////
                        ///Delivery Status...............
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Container(
                                width: 120,
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
                                  children: [
                                    Expanded(
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Delivery Status',
                                              style: TextStyle(
                                                color: Color(0xFF333333),
                                                fontSize: 20,
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
                              SizedBox(width: 20.0),
                              Container(
                                width: 160,
                                height: 60,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 4, color: Color(0xFF333333)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  value:
                                      selectedDeliveryStatus, // Default value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedDeliveryStatus = newValue!;
                                    });
                                  },
                                  items: <String>['delivered', 'on delivery']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                ///////////////////////////////////////
                /////////////////////////////////////
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    // Add your delete parcel logic here
                    print("Delete Parcel tapped!");
                    // You can replace the print statement with the actual logic to delete the parcel.
                  },
                  child: Container(
                    width: 294,
                    height: 36,
                    decoration: ShapeDecoration(
                      color: Color(0xFFCF0000),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Delete Parcel',
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
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    // Add your delete parcel logic here
                    print("Delete Parcel tapped!");
                    // You can replace the print statement with the actual logic to delete the parcel.
                  },
                  child: Container(
                    width: 294,
                    height: 36,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFFD233),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Update',
                                  style: TextStyle(
                                    color: Colors.black,
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
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
