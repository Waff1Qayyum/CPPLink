import 'dart:async';
import 'dart:io';

import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class DeliveryProof extends StatefulWidget {
  const DeliveryProof({super.key});

  @override
  State<DeliveryProof> createState() => _DeliveryListSProof();
}

class _DeliveryListSProof extends State<DeliveryProof> {
  dynamic image;
  XFile? fileImage;
  File? imageFile;
  bool isImageSelected = false;
  bool isLoading = false;
  String _selectedStatusType = 'Delivered';

  Future<void> uploadImage() async {
    try {
      final imageExtension = fileImage!.path.split('.').last.toLowerCase();
      final imageBytes = await fileImage!.readAsBytes();

      final bookingId = rider_parcel_list[booking_index]['booking_id'];

      final imagePath = '/$bookingId/proof';
      await supabase.storage.from('parcel_proof').uploadBinary(
          imagePath, imageBytes,
          fileOptions:
              FileOptions(upsert: true, contentType: 'image/$imageExtension'));

      image = supabase.storage
          .from('parcel_proof')
          .getPublicUrl('/$bookingId/proof');
      image = Uri.parse(image).replace(queryParameters: {
        't': DateTime.now().millisecondsSinceEpoch.toString()
      }).toString();
      await supabase
          .from('booking')
          .update({'picture_url': image}).eq('booking_id', bookingId);
    } catch (e) {
      return;
    }
  }

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

  Future<void> completeDelivery() async {
    await supabase.from('booking').update({'booking_status': 'delivered'}).eq(
        'booking_id', rider_parcel_list[booking_index]['booking_id']);
    await supabase.from('parcel').update({'status': 'delivered'}).eq(
        'tracking_id', rider_parcel_list[booking_index]['parcel_id']);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(248, 162, 41, 1),
          centerTitle: true,
          title: Text(
            'Complete Delivery',
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
              Navigator.of(context).pushReplacementNamed('/delivery_list');
            },
          ),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Complete Delivery',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 38,
                          fontFamily: 'Montagu Slab',
                          fontWeight: FontWeight.w400,
                          height: 0.00,
                        ),
                      ),
                      SizedBox(height: 20),
                      ///////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Customer Details :',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 17,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 0.00,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
                                  Row(
                                    children: [
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
                                        rider_parcel_list[booking_index]
                                            ['parcel']['tracking_id'],
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 17,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0.00,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
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
                                      Text(
                                        rider_parcel_list[booking_index]
                                            ['parcel']['name'],
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
                                  Row(
                                    children: [
                                      Text(
                                        'Phone : ',
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 17,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0.00,
                                        ),
                                      ),
                                      Text(
                                        rider_parcel_list[booking_index]
                                            ['phone'],
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
                                  Row(
                                    children: [
                                      Text(
                                        'Address : ',
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 17,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0.00,
                                        ),
                                      ),
                                      Text(
                                        rider_parcel_list[booking_index]
                                                ['address'] ??
                                            'MA1,KTDI',
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
                                ],
                              ),
                              SizedBox(width: 10),
                              // Adjust the spacing between columns
                              // Right column with data
                            ],
                          ),
                        ),
                      ),
                      //////////////////////////
                      SizedBox(height: 30),
                      ///////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery Status :',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 17,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 0.00,
                            ),
                          ),
                        ],
                      ),
                      //////////////////////////
                      SizedBox(height: 10),
                      ///////////////////////////
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
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Status : ', // Replace with actual data
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 0.5,
                                          color: Color.fromARGB(56, 25, 25, 25),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                164, 117, 117, 117),
                                            blurRadius: 4,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        value: _selectedStatusType,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedStatusType = newValue!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              255, 249, 249, 249),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 10,
                                          ),
                                        ),
                                        items:
                                            ["Delivered"].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select status type';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Proof: ', // Replace with actual data
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.00,
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    children: [
                                      Container(
                                        width: 160,
                                        height: 160,
                                        color: Color.fromARGB(255, 156, 156,
                                            156), // Set the background color to blue
                                        child: isImageSelected == true
                                            ? Image(
                                                image: FileImage(imageFile!))
                                            : Center(
                                                child: Text('No image'),
                                              ),
                                      ),
                                      Container(
                                        width: 150,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            getImage();
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blue),
                                          ),
                                          child: Text(
                                            'Upload Photo',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontFamily: 'Lexend',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Add your widgets related to the second status here
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      /////////////////////////////
                      SizedBox(height: 20),
                      /////////////////////////////
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await uploadImage();
                          await completeDelivery();
                          await getData(rider['user_id']);
                          await getRiderParcel(rider['rider_id']);
                          print('upload button press');
                          Navigator.of(context)
                              .pushReplacementNamed('/delivery_list');
                          Fluttertoast.showToast(
                            msg: "Delivery completed!",
                          );
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Container(
                          width: 263,
                          height: 53,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            color: const Color.fromARGB(255, 44, 174, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                width: 1.50,
                                color: const Color.fromARGB(255, 44, 174, 48),
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
                          child: isLoading == false
                              ? Text(
                                  'Confirm',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : Text(
                                  'Loading..',
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
                    ],
                  ),
                ),
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
      ),
    );
  }
}
