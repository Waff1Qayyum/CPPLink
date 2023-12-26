import 'package:cpplink/controller.dart';
import 'package:cpplink/main.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class customerQuickScan extends StatefulWidget {
  const customerQuickScan({super.key});

  @override
  State<customerQuickScan> createState() => _customerQuickScanState();
}

class _customerQuickScanState extends State<customerQuickScan> {
  TextEditingController qrController = TextEditingController();
  String? dropdownValue = user_parcel[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 195, 44, 1),
        centerTitle: true,
        title: Text(
          'Customer Homepage',
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
            Navigator.of(context).pushReplacementNamed('/customer_home');
          },
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        supabase.auth.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Color(0xFFFF0000),
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      )),
                ],
              )),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: QrImageView(
              data: dropdownValue.toString(),
              // data: qrController.text,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          Center(
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
            ),
          ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.5,
          //   child: TextFormField(
          //     decoration: InputDecoration(
          //       label: Text('Name'),
          //       border: OutlineInputBorder(),
          //     ),
          //     controller: qrController,
          //     onChanged: (value) {
          //       setState(() {});
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
