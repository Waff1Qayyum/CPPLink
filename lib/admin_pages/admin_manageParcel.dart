// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../controller.dart';

class AdminManageParcel extends StatefulWidget {
  const AdminManageParcel({super.key});

  @override
  State<AdminManageParcel> createState() => _AdminManageParcelState();
}

class _AdminManageParcelState extends State<AdminManageParcel> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  dynamic user_list = user_data;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateList(String value) {
    setState(() {
      user_list = user_data
          .where((element) =>
              element['name'] != null &&
              element['name']!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
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
            'Manage Parcel',
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
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Container(
                          width: 280,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: TextField(
                                    onChanged: (val) {
                                      setState(() {
                                        updateList(val);
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Search Parcel or Customer...',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      ////////////////
                      ////////////////
                      ////////////////
                      ////////////////
                      SizedBox(width: 10),

                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: isLoading == true ? null : () async {},
                          child: Container(
                            width: 70,
                            height: 53,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  width: 1.50,
                                  color: Colors.blue, // Border color
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
                                    'Search',
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
                      ),
                    ]),
                ////////////////////
                ////////////////////
                ////////////////////
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: isLoading == true ? null : () async {},
                        child: Container(
                          width: 120, // Adjust the width as needed
                          height: 40,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                width: 1.50,
                                color: Colors.green, // Border color
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
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                        width:
                                            5), // Adjust the spacing as needed
                                    Text(
                                      'Add parcel',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 15,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      )
                    ],
                  ),
                ),

                /////////////////
                /////////////////
                /////////////////
                /////////////////
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Table(
                    border: TableBorder.all(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFD233),
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Parcel Detail',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Delivery Status',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(''),
                            ),
                          ),
                        ],
                      ),
                      // TableRow(
                      //   children: [
                      //     TableCell(
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               'Tracking Number',
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 15,
                      //                 fontFamily: 'Lexend',
                      //               ),
                      //             ),
                      //             Text('Tel Number',
                      //                 style: TextStyle(
                      //                   color: Colors.black,
                      //                   fontSize: 15,
                      //                   fontFamily: 'Lexend',
                      //                 )),
                      //             Text('Name',
                      //                 style: TextStyle(
                      //                   color: Colors.black,
                      //                   fontSize: 15,
                      //                   fontFamily: 'Lexend',
                      //                 )),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     TableCell(
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Text('Delivered',
                      //             style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 15,
                      //               fontFamily: 'Lexend',
                      //               // fontWeight: FontWeight.w400,
                      //             )),
                      //       ),
                      //     ),
                      //     TableCell(
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Text('Edit'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // TableRow(
                      //   decoration: BoxDecoration(
                      //     color: Color.fromARGB(255, 255, 220, 94),
                      //   ),
                      //   children: [
                      //     TableCell(
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text('Tracking Number',
                      //                 style: TextStyle(
                      //                   color: Colors.black,
                      //                   fontSize: 15,
                      //                   fontFamily: 'Lexend',
                      //                 )),
                      //             Text('Tel Number',
                      //                 style: TextStyle(
                      //                   color: Colors.black,
                      //                   fontSize: 15,
                      //                   fontFamily: 'Lexend',
                      //                 )),
                      //             Text('Name',
                      //                 style: TextStyle(
                      //                   color: Colors.black,
                      //                   fontSize: 15,
                      //                   fontFamily: 'Lexend',
                      //                 )),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     TableCell(
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Text('On Delivery',
                      //             style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 15,
                      //               fontFamily: 'Lexend',
                      //             )),
                      //       ),
                      //     ),
                      //     TableCell(
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Text('Edit',
                      //             style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 15,
                      //               fontFamily: 'Lexend',

                      for (var rowData in user_list)
                        TableRow(
                          decoration: BoxDecoration(
                            color: user_list.indexOf(rowData) % 2 == 0
                                ? Color.fromARGB(255, 255, 220, 94)
                                : null,
                          ),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rowData['name'].toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Lexend',
                                      ),
                                    ),
                                    Text(
                                      rowData['phone'].toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Lexend',
                                      ),
                                    ),
                                    Text(
                                      'Tracking Number',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Lexend',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  // rowData['deliveryStatus'].toString(),
                                  'test',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Edit',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Lexend',
                                    )),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
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
