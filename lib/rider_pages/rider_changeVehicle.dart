import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controller.dart';
import '../main.dart';

class RiderChangeVehicle extends StatefulWidget {
  const RiderChangeVehicle({super.key});

  @override
  State<RiderChangeVehicle> createState() => _RiderChangeVehicleState();
}

class _RiderChangeVehicleState extends State<RiderChangeVehicle> {
  dynamic image;
  XFile? fileImage;
  File? imageFile;
  bool isImageSelected = false;
  bool? passMatch;
  bool isLoading = false;
  String _selectedVehicleType = 'Motorcycle';

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _plateController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _colourController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    super.initState();
    displayImage();
    assignData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> checkPassword() async {
    bool? match;
    match = await supabase.rpc('check_password',
        params: {'password_input': _passwordController.text});
    if (match == true || match == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> displayImage() async {
    final res = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('rider')
        .select('picture_url')
        .eq('user_id', res)
        .single();

    if (data['picture_url'] == null) {
      return;
    }

    if (mounted) {
      setState(() {
        image = data['picture_url'];
      });
    }
  }

  Future<void> assignData() async {
    final userId = await supabase.auth.currentUser!.id;
    final data =
        await supabase.from('rider').select().eq('user_id', userId).single();
    try {
      _plateController.text = data['plate_number'];
      _modelController.text = data['vehicle_model'];
      _typeController.text = data['vehicle_type'];
      _colourController.text = data['vehicle_colour'];
    } catch (e) {
      return;
    }
  }

  Future<void> changeVehicle() async {
    final userId = await supabase.auth.currentUser!.id;
    await supabase.from('rider').update({
      'vehicle_model': _modelController.text.toUpperCase(),
      'vehicle_colour': _colourController.text.toUpperCase(),
      'vehicle_type': _typeController.text.toUpperCase(),
      'plate_number': _plateController.text.toUpperCase()
    }).eq('user_id', userId);
  }

  Future<void> uploadImage() async {
    if (fileImage == null) {
      return;
    }

    final userId = supabase.auth.currentUser!.id;
    final imageExtension = fileImage!.path.split('.').last.toLowerCase();
    final imageBytes = await fileImage!.readAsBytes();

    // final res = supabase.auth.currentUser!.id;
    final rider = await supabase
        .from('rider')
        .select('rider_id')
        .eq('user_id', userId)
        .single();
    final riderId = rider['rider_id'];

    final imagePath = '/$riderId/vehicle';
    await supabase.storage.from('vehicle').uploadBinary(imagePath, imageBytes,
        fileOptions:
            FileOptions(upsert: true, contentType: 'image/$imageExtension'));

    image = supabase.storage.from('vehicle').getPublicUrl('/$riderId/vehicle');
    image = Uri.parse(image).replace(queryParameters: {
      't': DateTime.now().millisecondsSinceEpoch.toString()
    }).toString();
    await supabase
        .from('rider')
        .update({'picture_url': image}).eq('rider_id', riderId);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 195, 44, 1),
        centerTitle: true,
        title: Text(
          'Update Profile',
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
                context, '/rider_profile', (route) => false);
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      './images/cpp_logo.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  Text(
                    'CPP',
                    style: TextStyle(
                      color: Color(0xFF050505),
                      fontSize: 48,
                      fontFamily: 'Montagu Slab',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Text(
                    'Link',
                    style: TextStyle(
                      color: Color(0xFFFFD233),
                      fontSize: 32,
                      fontFamily: 'Montagu Slab',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                'Update Vehicle Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9B9B9B),
                  fontSize: 17,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: isImageSelected == true
                                ? Image(image: FileImage(imageFile!))
                                : ((vehicle_url != null)
                                    ? vehicle_picture!
                                    : Container(
                                        color: Colors.grey,
                                        child: const Center(
                                          child: Text('No image'),
                                        ),
                                      )),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              getImage();
                            },
                            child: Text('Upload Photo'),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Select to update',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF9B9B9B),
                              fontSize: 17,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Plate Number :'),
                              SizedBox(height: 10),
                              Container(
                                width: 263,
                                height: 37,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Color.fromARGB(56, 25, 25, 25),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(164, 117, 117, 117),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: _plateController,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    hintText: "plate number",
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 249, 249, 249),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 1.50,
                                        color: Color(0xFFFFD233),
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Color(0xFFFFD233),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter plate number';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Vehicle Model : '),
                              SizedBox(height: 10),
                              Container(
                                width: 263,
                                height: 37,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Color.fromARGB(56, 25, 25, 25),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(164, 117, 117, 117),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: _modelController,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    hintText: "vehicle model",
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 249, 249, 249),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 1.50,
                                        color: Color(0xFFFFD233),
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Color(0xFFFFD233),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter vehicle model';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Vehicle Type :'),
                              SizedBox(height: 10),
                              Container(
                                width: 263,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Color.fromARGB(56, 25, 25, 25),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(164, 117, 117, 117),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedVehicleType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedVehicleType = newValue!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 249, 249, 249),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 1.50,
                                        color: Color(0xFFFFD233),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    prefixIcon: Icon(
                                      Icons.delivery_dining_outlined,
                                      color: Color(0xFFFFD233),
                                    ),
                                  ),
                                  items:
                                      ["Motorcycle", "Car"].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select vehicle type';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Vehicle Colour :'),
                              SizedBox(height: 10),
                              Container(
                                width: 263,
                                height: 37,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Color.fromARGB(56, 25, 25, 25),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(164, 117, 117, 117),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: _colourController,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    hintText: "vehicle colour ",
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 249, 249, 249),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 1.50,
                                        color: Color(0xFFFFD233),
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Color(0xFFFFD233),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter vehicle colour';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Enter your password for confirmation',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF9B9B9B),
                              fontSize: 17,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 263,
                            height: 37,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 0.5,
                                color: Color.fromARGB(56, 25, 25, 25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(164, 117, 117, 117),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                hintText: "enter a password ",
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 249, 249, 249),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1.50,
                                    color: Color(0xFFFFD233),
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Color(0xFFFFD233),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                } else if (passMatch == false) {
                                  return 'Password does not match';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 30),
                              InkWell(
                                onTap: isLoading == true
                                    ? null
                                    : () async {
                                        // Your code to handle the tap event
                                        try {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          passMatch = await checkPassword();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await uploadImage();
                                            await changeVehicle();
                                            await getData(getID());

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Vehicle Detail Updated Successfully')));
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/rider_profile',
                                                (route) => false);
                                          }

                                          setState(() {
                                            isLoading = false;
                                          });
                                        } catch (e) {
                                          return;
                                        }
                                      },
                                child: Container(
                                  width: 135,
                                  height: 53,
                                  alignment: Alignment.center,
                                  decoration: ShapeDecoration(
                                    color:
                                        const Color.fromARGB(255, 44, 174, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        width: 1.50,
                                        color: const Color.fromARGB(
                                            255, 44, 174, 48),
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
                                  child: isLoading == true
                                      ? CircularProgressIndicator()
                                      : Text(
                                          'confirm',
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
