import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controller.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  var _currentDeliveryList = currentDeliveryList;
  String? dropdownValue = currentDeliveryList[0];
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
            Navigator.of(context).pushReplacementNamed('/delivery_list');
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
                        Center(
                          child: QrImageView(
                            data: dropdownValue.toString(),
                            // data: qrController.text,
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
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
                            items: _currentDeliveryList.map((String parcelID) {
                              return DropdownMenuItem<String>(
                                child: Text(parcelID),
                                value: parcelID,
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
