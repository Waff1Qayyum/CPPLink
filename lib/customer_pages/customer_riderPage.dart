import 'dart:io';

import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class customerRiderPage extends StatefulWidget {
  const customerRiderPage({super.key});

  @override
  State<customerRiderPage> createState() => customerBbookingState();
}

class customerBbookingState extends State<customerRiderPage> {
  bool isImageSelected = false;
  XFile? fileImage;
  File? imageFile;

  void getImage() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
        isImageSelected = true;
      });
    }
    setState(() {
      fileImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 195, 44, 1),
        centerTitle: true,
        title: Text(
          'My Rider',
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
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  'My Rider',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 38,
                    fontFamily: 'Montagu Slab',
                    fontWeight: FontWeight.w400,
                    height: 0.00,
                  ),
                ),
                /////////////////////////////
                SizedBox(
                  height: 40,
                ),
                /////////////////////////////
                Row(
                  children: [
                    Text(
                      'Parcel details: ',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0.00,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                /////////////////////////////
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /////////////
                            ////////////
                            Text(
                              'Track Num. : ',
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 17,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0.00,
                              ),
                            ),
                            Text(
                              'Name : ',
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 17,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0.00,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Address :',
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
                        SizedBox(width: 10),
                        // Adjust the spacing between columns
                        // Right column with data
                        Expanded(
                          // child: SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Fetch and display data from the database here
                              // Example:
                              // Text(
                              //   user_booking[], // Replace with actual data
                              //   style: TextStyle(
                              //     color: Color(0xFF333333),
                              //     fontSize: 17,
                              //     fontFamily: 'Roboto',
                              //     fontWeight: FontWeight.w400,
                              //     height: 0.00,
                              //   ),
                              // ),
                              ListView.builder(
                                itemCount: user_booking.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Text(
                                    user_booking[
                                        index], // Use the current element in the list
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                user_name, // Replace with actual data
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 17,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 0.00,
                                ),
                                overflow: TextOverflow.visible,
                              ),
                              Text(
                                'MA1, KTDI', // Replace with actual data
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
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
                ////////////////////////////
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Rider details: ',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0.00,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                /////////////////////////////
                ///////////////////////////
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 87, 255, 93),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 10, right: 10, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 120,
                                height: 150,
                                child: isImageSelected == true
                                    ? Image(image: FileImage(imageFile!))
                                    : Container(
                                        color: const Color.fromARGB(
                                            255, 154, 154, 154),
                                        child: const Center(
                                          child: Text('No image'),
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'MUHAMMAD WAFFI QAYYUM BIN DIN', // Replace with actual data
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      height:
                                          1.2, // Adjust the height as needed
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Vehicle Details : ',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      height: 0.00,
                                    ),
                                  ),
                                  Text(
                                    'Car',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  Text(
                                    'JYP1231',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  Text(
                                    'Proton Myvi',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  Text(
                                    'Red',
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  SizedBox(height: 10)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //////////////////////////////////
                /////////////////////////////////
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total Charge : ',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0.00,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'RM 5.00',
                      style: TextStyle(
                        color: Color.fromARGB(255, 14, 173, 19),
                        fontSize: 30,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0.00,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                /////////////////////////////
                ////////////////////////////////
              ],
            ),
          ),
        ],
      ),
    );
  }
}
