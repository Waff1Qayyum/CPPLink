// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../controller.dart';

class AdminManageParcel extends StatefulWidget {
  const AdminManageParcel({super.key});

  @override
  State<AdminManageParcel> createState() => _AdminManageParcelState();
}

class _AdminManageParcelState extends State<AdminManageParcel> {
  String parcelStatus = 'All';
  String searchInput = "";
  bool isLoading = false;
  dynamic user_list = user_data;
  dynamic parcel_list = parcel_data;
  dynamic sorted_list;
  int parcel_counter = 0;
  int delivery_counter = 0;

  @override
  void initState() {
    super.initState();
    userNameList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void sortTrackingNumber() {
    parcel_list = List.from(parcel_list);
    setState(() {
      if (parcel_counter == 1) {
        parcel_list.sort((a, b) =>
            (a['tracking_id'] as String).compareTo(b['tracking_id'] as String));
      } else {
        parcel_list.sort((a, b) =>
            (b['tracking_id'] as String).compareTo(a['tracking_id'] as String));
      }
    });
  }

  void sortDeliveryStatus() {
    parcel_list = List.from(parcel_list);
    setState(() {
      if (delivery_counter == 1) {
        parcel_list.sort(
            (a, b) => (a['status'] as String).compareTo(b['status'] as String));
      } else {
        parcel_list.sort(
            (a, b) => (b['status'] as String).compareTo(a['status'] as String));
      }
    });
  }

  void filterParcel() {
    parcel_list = List.from(parcel_list);
    parcel_counter = 0;
    delivery_counter = 0;
    setState(() {
      //has input
      if (searchInput.isNotEmpty) {
        //has input, status all
        if (parcelStatus == 'All') {
          parcel_list = parcel_data
              .where((element) =>
                  (element['user_id'] != null ||
                      element['tracking_id'] != null) &&
                  (element['name']!
                          .toLowerCase()
                          .contains(searchInput.toLowerCase()) ||
                      element['tracking_id']!
                          .toLowerCase()
                          .contains(searchInput.toLowerCase())))
              .toList();
          return;
        } else
        //has input, status is not all
        {
          parcel_list = parcel_data
              .where((element) =>
                  (element['user_id'] != null ||
                      element['tracking_id'] != null) &&
                  (element['name']!
                          .toLowerCase()
                          .contains(searchInput.toLowerCase()) ||
                      element['tracking_id']!
                          .toLowerCase()
                          .contains(searchInput.toLowerCase())) &&
                  (element['status'].contains(parcelStatus.toLowerCase())))
              .toList();
          return;
        }
        // has no input
      } else {
        //has no input, status is all
        if (parcelStatus == 'All') {
          parcel_list = parcel_data;
          return;
        } else {
          //has no input, status is not all
          parcel_list = parcel_data
              .where((element) =>
                  (element['user_id'] != null ||
                      element['tracking_id'] != null) &&
                  (element['status'].contains(parcelStatus.toLowerCase())))
              .toList();
          return;
        }
      }
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
                Row(children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.black),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    searchInput = val;
                                    filterParcel();
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
                ]),
                ////////////////////
                ////////////////////
                ////////////////////
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: isLoading == true
                            ? null
                            : () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Filter by'),
                                        insetPadding: EdgeInsets.zero,
                                        content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                title: Text('All'),
                                                onTap: () {
                                                  setState(() {
                                                    parcelStatus = 'All';
                                                    filterParcel();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: Text('Arrived'),
                                                onTap: () {
                                                  setState(() {
                                                    parcelStatus = 'Arrived';
                                                    filterParcel();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: Text('Cancelled'),
                                                onTap: () {
                                                  setState(() {
                                                    parcelStatus = 'Cancelled';
                                                    filterParcel();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: Text('Collected'),
                                                onTap: () {
                                                  setState(() {
                                                    parcelStatus = 'Collected';
                                                    filterParcel();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: Text('Delivered'),
                                                onTap: () {
                                                  setState(() {
                                                    parcelStatus = 'Delivered';
                                                    filterParcel();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: Text('Waiting'),
                                                onTap: () {
                                                  setState(() {
                                                    parcelStatus = 'Waiting';
                                                    filterParcel();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ]),
                                      );
                                    });
                              },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 130, // Adjust the width as needed
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
                                        Icons.sort,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(
                                          width:
                                              5), // Adjust the spacing as needed
                                      Text(
                                        parcelStatus,
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
                        ),
                      ),
                      InkWell(
                        onTap: isLoading == true
                            ? null
                            : () async {
                                Navigator.pushNamed(
                                    context, '/admin_registerParcel');
                              },
                        child: Container(
                          width: 130, // Adjust the width as needed
                          height: 40,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                width: 1.50,
                                color: Color.fromARGB(
                                    255, 39, 141, 225), // Border color
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
                                      'Add Parcel',
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
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Parcel Detail',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        parcel_counter++;
                                        parcel_counter = parcel_counter % 2;
                                        sortTrackingNumber();
                                        print(
                                            'Parcel Counter: ${parcel_counter}');
                                      });
                                    },
                                    child: parcel_counter == 0
                                        ? Icon(Icons.arrow_downward_rounded)
                                        : Icon(Icons.arrow_upward_rounded),
                                  )
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
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
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        delivery_counter++;
                                        delivery_counter = delivery_counter % 2;
                                        sortDeliveryStatus();
                                      });
                                    },
                                    child: delivery_counter == 0
                                        ? Icon(Icons.arrow_downward_rounded)
                                        : Icon(Icons.arrow_upward_rounded),
                                  )
                                ],
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
                      for (var rowData
                          in parcel_list) //change to user_list to display user
                        TableRow(
                          decoration: BoxDecoration(
                            color: parcel_list.indexOf(rowData) % 2 == 0
                                ? Color.fromARGB(255, 255, 245, 211)
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
                                      rowData['tracking_id'].toString(),
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
                                  rowData['status'].toString(),
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
                                child: GestureDetector(
                                  onTap: () {
                                    int i = parcel_list.indexOf(rowData);
                                    edit_parcel = parcel_list[i];
                                    tracking_id = edit_parcel['tracking_id'];
                                    customerName = edit_parcel['name'];
                                    customerNumber = edit_parcel['phone'];
                                    dateArrived = edit_parcel['date_arrived'];
                                    status = edit_parcel['status'];
                                    Navigator.pushNamed(
                                        context, '/admin_updateParcel');
                                  },
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors
                                          .blue, // Set the color you desire
                                      fontSize: 15,
                                      fontFamily: 'Lexend',
                                      decoration: TextDecoration
                                          .underline, // Add underline
                                    ),
                                  ),
                                ),
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
