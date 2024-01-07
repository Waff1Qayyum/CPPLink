import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class RiderQuickScan extends StatefulWidget {
  const RiderQuickScan({super.key});

  @override
  State<RiderQuickScan> createState() => _RiderQuickScanState();
}

class _RiderQuickScanState extends State<RiderQuickScan> {
  TextEditingController qrController = TextEditingController();

  String? dropdownValue = "";

  updateListParcel() async {
    await getArrivedParcel(currentUserID);
    if (user_parcel.isNotEmpty && user_parcel[0] != "") {
      dropdownValue = user_parcel[0];
    } else {
      dropdownValue = "";
    }
    if (mounted) {
      setState(() {
        user_parcel;
      });
    }
  }

  @override
  void initState() {
    updateListParcel();
    super.initState();

    if (mounted) {
      //listen to realtime changes on database
      supabase
          .channel('public:customer')
          .onPostgresChanges(
              event: PostgresChangeEvent.all,
              schema: 'public',
              table: 'parcel',
              callback: (payload) {
                print('Change received: ${payload.toString()}');
                updateListParcel();
              })
          .subscribe();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 195, 44, 1),
        centerTitle: true,
        title: Text(
          'Quick Scan',
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
            // Navigator.of(context).pushReplacementNamed('/');
            Navigator.of(context).pushReplacementNamed('/rider_home');
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                      'Show the generated Qr at CPP to easily get your parcel detail.',
                      style: TextStyle(
                        color: Color(0xFF050505),
                        fontSize: 17,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                        height: 0.00,
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Column(children: [
                        Text('Parcel Qr',
                            style: TextStyle(
                              color: Color(0xFF050505),
                              fontSize: 17,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                              height: 0.00,
                            )),
                        SizedBox(
                          height: 12,
                        ),
                        dropdownValue != ""
                            ? Center(
                                child: QrImageView(
                                  data: dropdownValue.toString(),
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              )
                            : Center(
                                child: Container(
                                    height: 200,
                                    width: 200,
                                    color: const Color.fromARGB(
                                        255, 214, 214, 214),
                                    child: Expanded(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          Text(
                                            "No Tracking Number",
                                            style: TextStyle(
                                              color: Color(0xFF050505),
                                              fontSize: 17,
                                              fontFamily: 'Lexend',
                                              fontWeight: FontWeight.w400,
                                              height: 0.00,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ]))),
                              )
                      ]),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Select Your Parcel Track Number : ',
                          style: TextStyle(
                            color: Color(0xFF050505),
                            fontSize: 17,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 0.00,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 250,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            items: user_parcel.map((String parcel) {
                              return DropdownMenuItem<String>(
                                child: Text(parcel),
                                value: parcel,
                              );
                            }).toList(),
                            onChanged: (value) => setState(() {
                              dropdownValue = value;
                            }),
                            isExpanded: true,
                            elevation: 8, // Set the position to below
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ))

          // Center(),
        ],
      ),
    );
  }
}
