import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../controller.dart';
import '../main.dart';

class AdminRegisterParcel extends StatefulWidget {
  const AdminRegisterParcel({super.key});

  @override
  State<AdminRegisterParcel> createState() => _AdminRegisterParcelState();
}

class _AdminRegisterParcelState extends State<AdminRegisterParcel> {
  bool isLoading = false;
  bool? phoneValid;
  bool? parcelUnique;
  bool? userExist;
  String? phone;
  String? userSelected;
  TextEditingController _trackingNumber = TextEditingController();
  TextEditingController _customerName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime? current;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> registerParcel() async {
    // try {

    if (userExist == true) {
      final userId = await supabase
          .from('user')
          .select('user_id')
          .eq('name', _customerName.text.toUpperCase())
          .single();

      await supabase.from('parcel').insert({
        'tracking_id': _trackingNumber.text.toUpperCase(),
        'user_id': userId['user_id'],
        'name': _customerName.text.toUpperCase(),
        'phone': phone,
      });

      Navigator.pushNamedAndRemoveUntil(
          context, '/admin_manageParcel', (route) => false);

      return;
    }

    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text('User does not exist'),
              actions: [
                TextButton(
                    onPressed: () {
                      print('cancel register');
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      await supabase.from('parcel').insert({
                        'tracking_id': _trackingNumber.text.toUpperCase(),
                        'name': _customerName.text.toUpperCase(),
                        'phone': phone,
                      });
                      Fluttertoast.showToast(
                        msg: "The parcel has been Added!",
                      );
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/admin_manageParcel', (route) => false);
                      print('register successfully!');
                    },
                    child: const Text('Register Anyway'))
              ],
            ));

    // await supabase.from('parcel').insert({
    //   'tracking_id': _trackingNumber.text.toUpperCase(),
    //   'name': _customerName.text.toUpperCase(),
    //   'phone': phone,
    // });

    // } catch (error) {
    //   print('Error updating parcel: $error');
    // }
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
            'Register Parcel',
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
              Navigator.of(context).pushReplacementNamed('/admin_manageParcel');
            },
          ),
        ),
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(children: [
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: 220, // Adjusted width
                  height: 70, // Adjusted height
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(25), // Increased border radius
                    color: Colors.transparent,
                  ),
                  child: Stack(
                    children: [
                      // Background container
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: ShapeDecoration(
                          color: Color(0xFF0F0AF9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25), // Increased border radius
                          ),
                        ),
                      ),
                      // Inner shadow container
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              25), // Increased border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Register Parcel',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0.00,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////////
                ///////Dalam Kotak Kuning/////////
                Container(
                    width: 390,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFFD233),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(6, 5),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    ////////////////////////////////////////////////
                    ///Tracking Number.......
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 4, color: Color(0xFF333333)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Tracking Number',
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
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Container(
                                  width: 230,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 4, color: Color(0xFF333333)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please fill in';
                                      } else if (parcelUnique == false) {
                                        return 'Parcel Exist';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _trackingNumber,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .singleLineFormatter,
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "enter tracking number",
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 249,
                                          249, 249), // Background color
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
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 10),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        /////////////////////////////////////////////////
                        /////Name........
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 4, color: Color(0xFF333333)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Name',
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
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                TypeAheadField(
                                  suggestionsCallback: (value) {
                                    print('value : $value');
                                    if (value.isEmpty) {
                                      return List<String>.empty();
                                    }
                                    return list_name
                                        .where((element) => element
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                        .toList();
                                  },
                                  builder: (context, controller, focusNode) {
                                    return Container(
                                      width: 230,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 4,
                                              color: Color(0xFF333333)),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: _customerName,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        focusNode: focusNode,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please fill in';
                                          } else {
                                            return null;
                                          }
                                        },
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                          fontFamily: 'Lexend',
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                            hintText: 'enter name',
                                            filled: true,
                                            fillColor: const Color.fromARGB(
                                                255, 249, 249, 249),
                                            border: OutlineInputBorder(
                                              // Use OutlineInputBorder for rounded borders
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 10)),
                                        // autofocus: true,
                                      ),
                                    );
                                  },
                                  hideOnEmpty: true,
                                  emptyBuilder: (context) => Text(''),
                                  constraints: BoxConstraints(maxHeight: 500),
                                  itemBuilder: (context, String suggestion) {
                                    String selectPhone = "";
                                    for (var entry in list_user) {
                                      if (entry['name'] == suggestion) {
                                        selectPhone = entry['phone'];
                                      }
                                    }
                                    return ListTile(
                                      title: Text(suggestion),
                                      subtitle: Text(selectPhone),
                                    );
                                  },
                                  onSelected: (String suggestion) {
                                    setState(() {
                                      String selectPhone = "";
                                      for (var entry in list_user) {
                                        if (entry['name'] == suggestion) {
                                          selectPhone = entry['phone'];
                                        }
                                      }
                                      _customerName.text = suggestion;
                                      _phoneNumber.text = selectPhone;
                                    });
                                  },
                                  controller: _customerName,
                                ),
                              ]),
                        ),
                        SizedBox(height: 10),
                        //////////////////////////////////////////////////////
                        ///Phone......
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(children: [
                            Container(
                              width: 100,
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 4, color: Color(0xFF333333)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Phone',
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
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              width: 230,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 4, color: Color(0xFF333333)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please fill in';
                                  } else if (phoneValid == false) {
                                    return 'Invalid Phone Number';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _phoneNumber,
                                textCapitalization:
                                    TextCapitalization.characters,
                                textAlignVertical: TextAlignVertical.center,
                                maxLines: 1,
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                decoration: InputDecoration(
                                  hintText: "enter mobile numbers",
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
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    )),

                /////////////////////////
                /////////////////////////
                SizedBox(
                  height: 30.0,
                ),
                /////////////////////////
                /////////////////////////
                InkWell(
                  onTap: isLoading == true
                      ? null
                      : () async {
                          // Your code to handle the tap event
                          setState(() {
                            isLoading = true;
                          });
                          phone = await formatPhone(_phoneNumber.text);
                          phoneValid = await phone_check(phone!);
                          parcelUnique = await parcel_unique(
                              _trackingNumber.text.toUpperCase());
                          userExist = await user_exist(
                              _customerName.text.toUpperCase());
                          if (_formKey.currentState!.validate()) {
                            await registerParcel();
                            //change snackbar design
                            await getParcelList();
                          } else {
                            print('cannot register');
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                  child: Container(
                    width: 180,
                    height: 53,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: const Color.fromARGB(255, 44, 174, 48),
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
                            'Confirm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
