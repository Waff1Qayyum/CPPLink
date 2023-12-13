import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> uploadImage(dynamic id) async {
    try {
      final imageExtension = fileImage!.path.split('.').last.toLowerCase();
      final imageBytes = await fileImage!.readAsBytes();

      final rider = await supabase
          .from('rider')
          .select('rider_id')
          .eq('user_id', id)
          .single();
      final riderId = rider['rider_id'];

      final imagePath = '/$riderId/vehicle';
      await supabase.storage.from('vehicle').uploadBinary(imagePath, imageBytes,
          fileOptions:
              FileOptions(upsert: true, contentType: 'image/$imageExtension'));

      image =
          supabase.storage.from('vehicle').getPublicUrl('/$riderId/vehicle');
      image = Uri.parse(image).replace(queryParameters: {
        't': DateTime.now().millisecondsSinceEpoch.toString()
      }).toString();
      await supabase
          .from('rider')
          .update({'picture_url': image}).eq('rider_id', riderId);
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
        body: ListView(
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
                                Text(
                                  'EFX33290', // Replace with actual data
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 17,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0.00,
                                  ),
                                ),
                                Text(
                                  'MUHAMMAD WAFFI QAYYUM BIN DIN', // Replace with actual data
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
                                        color:
                                            Color.fromARGB(164, 117, 117, 117),
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
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 10,
                                      ),
                                    ),
                                    items: ["Delivered", "Not Delivered"]
                                        .map((String value) {
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
                                  SizedBox(
                                      width: 160,
                                      height: 160,
                                      child: isImageSelected == true
                                          ? Image(image: FileImage(imageFile!))
                                          : Container(
                                              color: const Color.fromARGB(
                                                  255, 154, 154, 154),
                                              child: const Center(
                                                child: Text('No image'),
                                              ),
                                            )),
                                  Container(
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        getImage();
                                      },
                                      child: Text('Upload Photo',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w700,
                                          )),
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
                  Container(
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
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Text(
                            'Loading..',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
