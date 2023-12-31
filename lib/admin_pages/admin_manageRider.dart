import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';

class ManageRiderPage extends StatefulWidget {
  const ManageRiderPage({super.key});

  @override
  State<ManageRiderPage> createState() => _ManageRiderPageState();
}

class _ManageRiderPageState extends State<ManageRiderPage> {
  String riderStatus = 'All';
  String searchInput = "";
  bool isLoading = false;
  // dynamic user_list = user_data;
  // dynamic parcel_list = parcel_data;
  // dynamic sorted_list;
  int riderCounter = 0;
  int delivery_counter = 0;

  // dynamic rider_list = all_rider_parcel_list;
  // dynamic rider_delivery_list = rider_parcel_delivery_list;

  // dynamic allRider_list_status = allRider_parcel_list_status;
  dynamic allRider_list_user = allRider_parcel_list_user;
  // dynamic allRider_list_booking = allRider_parcel_list_booking;
  dynamic listDeliveringParcel = listParcelID ;
  @override
  void initState() {
    super.initState();
    userNameList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void sortRiderName() {
    allRider_list_user = List.from(allRider_list_user);
    setState(() {
      if (riderCounter == 1) {
        allRider_list_user.sort((a, b) => (a['user']['name'] as String)
            .compareTo(b['user']['name'] as String));
      } else {
        allRider_list_user.sort((a, b) => (b['user']['name'] as String)
            .compareTo(a['user']['name'] as String));
      }
    });
  }

  void sortRiderStatus() {
    allRider_list_user = List.from(allRider_list_user);
    setState(() {
      if (delivery_counter == 1) {
        allRider_list_user.sort(
            (a, b) => (a['status'] as String).compareTo(b['status'] as String));
      } else {
        allRider_list_user.sort(
            (a, b) => (b['status'] as String).compareTo(a['status'] as String));
      }
    });
  }

  void filterRider() {
    allRider_list_user = List.from(allRider_list_user);
    riderCounter = 0;
    setState(() {
      //has input
      if (searchInput.isNotEmpty) {
        //has input, status all
        if (riderStatus == 'All') {
          allRider_list_user = allRider_parcel_list_user
              .where((element) =>
                  (element['rider_id'] != null) &&
                  (element['user']['name']!
                      .toLowerCase()
                      .contains(searchInput.toLowerCase())))
              .toList();
          return;
        } else
        //has input, status is not all
        {
          allRider_list_user = allRider_parcel_list_user
              .where((element) =>
                  (element['rider_id'] != null) &&
                  ((element['user']['name']!
                      .toLowerCase()
                      .contains(searchInput.toLowerCase()))) &&
                  (element['status'].contains(riderStatus.toLowerCase())))
              .toList();
          return;
        }
        // has no input
      } else {
        //has no input, status is all
        if (riderStatus == 'All') {
          allRider_list_user = allRider_parcel_list_user;
          return;
        } else {
          //has no input, status is not all
          allRider_list_user = allRider_parcel_list_user
              .where((element) =>
                  (element['rider_id'] != null) &&
                  (element['status'].contains(riderStatus.toLowerCase())))
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
            'Monitor Rider',
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
                                    filterRider();
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search Rider...',
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: isLoading == true
                            ? null
                            : () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Filter Rider Status by'),
                                        insetPadding: EdgeInsets.zero,
                                        content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                title: Text('All'),
                                                onTap: () {
                                                  setState(() {
                                                    riderStatus = 'All';
                                                    filterRider();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: Text('Delivering'),
                                                onTap: () {
                                                  setState(() {
                                                    riderStatus = 'Delivering';
                                                    filterRider();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: Text('Idle'),
                                                onTap: () {
                                                  setState(() {
                                                    riderStatus = 'Idle';
                                                    filterRider();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: Text('Offline'),
                                                onTap: () {
                                                  setState(() {
                                                    riderStatus = 'Offline';
                                                    filterRider();
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
                                        riderStatus,
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
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(4),
                      2: FlexColumnWidth(2),
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
                                    '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Rider Detail',
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
                                        riderCounter++;
                                        riderCounter = riderCounter % 2;
                                        sortRiderName();
                                        print('Rider Counter: ${riderCounter}');
                                      });
                                    },
                                    child: riderCounter == 0
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
                                      'Rider Status',
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
                                        sortRiderStatus();
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
                        ],
                      ),
                      for (var rowUser in allRider_list_user)
                        //change to user_list to display user // Debugging line
                        TableRow(
                          decoration: BoxDecoration(
                            color: allRider_list_user.indexOf(rowUser) % 2 == 0
                                ? Color.fromARGB(255, 255, 245, 211)
                                : null,
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
                                      (allRider_list_user.indexOf(rowUser) + 1)
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rowUser['user']['name'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Lexend',
                                      ),
                                    ),
                                    Text(
                                      rowUser['user']['phone'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Lexend',
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    // for (var ParceIDList in listDeliveringParcel)
                                    //   if (ParceIDList != null &&
                                    //       ParceIDList.length > 0)
                                    if (rowUser['booking'] != null && rowUser['booking'].length >0)
                                    for (var booking in rowUser['booking'])
                                    if (booking['parcelList'] != null && booking['parcelList'].length >0)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Delivering parcels :",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Lexend',
                                              ),
                                            ),

                                    for (var ParcelId in booking['parcelList'])
                                            Text(
                                              ParcelId,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: 'Lexend',
                                              ),
                                            ),
                                          ],
                                        )
                                  ],
                                ),
                              ),
                            ),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                rowUser['status'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Lexend',
                                ),
                              ),
                            )),
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
