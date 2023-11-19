import 'dart:async';

import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class CustomerChangeName extends StatefulWidget {
  const CustomerChangeName({super.key});

  @override
  State<CustomerChangeName> createState() => _CustomerChangeNameState();
}

class _CustomerChangeNameState extends State<CustomerChangeName> {
  bool isLoading = false;
  String? name;
  String? phone;
  String? email;
  String? _name;
  bool? passMatch;
  dynamic image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getName();
    getEmail();
    getPhone();
    displayImage();
  }

  Future<void> getName() async {
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('user')
        .select('name')
        .eq('user_id', userId)
        .single();
    if (mounted) {
      setState(() {
        name = data['name'];
      });
    }
  }

  Future<void> getPhone() async {
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('user')
        .select('phone')
        .eq('user_id', userId)
        .single();
    if (mounted) {
      setState(() {
        phone = data['phone'];
      });
    }
  }

  Future<void> getEmail() async {
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('user')
        .select('email')
        .eq('user_id', userId)
        .single();
    if (mounted) {
      setState(() {
        email = data['email'];
      });
    }
  }

  void dispose() {
    super.dispose();
  }

  Future<void> displayImage() async {
    final userId = supabase.auth.currentUser!.id;
    final res = await supabase
        .from('user')
        .select('picture_url')
        .eq('user_id', userId)
        .single();

    if (res['picture_url'] == null) {
      return;
    }

    if (mounted) {
      setState(() {
        image = res['picture_url'];
      });
    }
  }

  Future<bool> checkPassword() async {
    bool? match;
    match = await supabase.rpc('check_password',
        params: {'password_input': _passwordController.text});
    if (match == true || match == 1) {
      return true;
    } else
      return false;
  }

  Future<void> setUsername(String _name) async {
    String userId = supabase.auth.currentUser!.id;
    String name = _name.toUpperCase();
    await supabase
        .from('user')
        .update({'name': name}).match({'user_id': userId});
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
            Navigator.of(context).pushReplacementNamed('/customer_profile');
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
                  )),
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
              SizedBox(height: 40.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //row to put the buttons
                  children: [
                    Padding(
                        //padding for all column
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                            //row to put image + name
                            children: [
                              Container(
                                width: 100, // Adjust the width as needed
                                height: 100, // Adjust the height as needed
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFFFFD233), // Border color
                                    width: 1.0, // Border width
                                  ),
                                ),
                                child: ClipOval(
                                    child: image != null
                                        ? Image.network(
                                            image!,
                                            fit: BoxFit.cover,
                                            width: 70,
                                            height: 70,
                                          )
                                        : Container(
                                            color: Colors.grey,
                                          )),
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name ?? 'Loading..',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 22,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: Color(0xFFFFD233),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          phone ?? 'Loading..',
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 15,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w100,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: Color(0xFFFFD233),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          email ?? 'Loading..',
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 15,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w100,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ])
                            ])),
                  ]),
              /////////////////////////////////////
              SizedBox(height: 50),
              Text(
                'Change Your Account\'s Name ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9B9B9B),
                  fontSize: 17,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                ),
              ),
              ////////////////////////////////////
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter fullname';
                                } else {
                                  return null;
                                }
                              },
                              controller: _nameController,
                              textCapitalization: TextCapitalization.characters,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                hintText: "enter new full name",
                                filled: true,
                                fillColor: const Color.fromARGB(
                                    255, 249, 249, 249), // Background color
                                border: OutlineInputBorder(
                                  // Use OutlineInputBorder for rounded borders
                                  borderRadius: BorderRadius.circular(
                                      10), // This sets the rounded corners for the text field
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
                                  Icons.person,
                                  color: Color(0xFFFFD233),
                                ),
                              ),
                            ),
                          ),
                          ///////////////////////
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

                          //////////////////////
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
                                hintText: "enter password ",
                                filled: true,
                                fillColor: const Color.fromARGB(
                                    255, 249, 249, 249), // Background color
                                border: OutlineInputBorder(
                                  // Use OutlineInputBorder for rounded borders
                                  borderRadius: BorderRadius.circular(
                                      10), // This sets the rounded corners for the text field
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
                          SizedBox(height: 70),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //////////////////
                                SizedBox(width: 30),
                                //////////////////
                                InkWell(
                                  onTap: isLoading == true
                                      ? null
                                      : () async {
                                          // Your code to handle the tap event
                                          setState(() {
                                            isLoading = true;
                                          });
                                          passMatch = await checkPassword();
                                          _name =
                                              formatName(_nameController.text);
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await setUsername(_name!);
                                            //change snackbar design
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Name Updated Successfully')));
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/customer_profile',
                                                (route) => false);
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                  child: Container(
                                    width: 135,
                                    height: 53,
                                    alignment: Alignment.center,
                                    decoration: ShapeDecoration(
                                      color: const Color.fromARGB(
                                          255, 44, 174, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          width: 1.50,
                                          color: const Color.fromARGB(
                                              255, 44, 174, 48), // Border color
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
                              ])
                        ],
                      ),
                      //////////////////////////////

                      ///////////////////////////
                    ),
                  ],
                  // ],
                ),
              ),

              ///end
            ],
          ),
        ],
      ),
    );
  }
}
