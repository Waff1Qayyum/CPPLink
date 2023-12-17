import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../controller.dart';
import '../main.dart';

class AdminUpdateParcel extends StatefulWidget {
  const AdminUpdateParcel({super.key});

  @override
  State<AdminUpdateParcel> createState() => _AdminUpdateParcelState();
}

class _AdminUpdateParcelState extends State<AdminUpdateParcel> {
  // String selectedPaymentStatus = 'not paid';
  // String selectedDeliveryStatus = 'on delivery';
  bool? phoneValid;
  bool? nameValid;
  String? phone;
  bool isLoading = false;
  TextEditingController _trackingNumber = TextEditingController();
  TextEditingController _customerName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController deliveryStatusController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void initializevariables() async {
    _trackingNumber.text = tracking_id;
    _customerName.text = customerName;
    _phoneNumber.text = customerNumber;
    deliveryStatusController.text = status;

    print('all variables initialized.');
  }

  Future<void> updateParcel() async {
    try {
      await supabase.from('parcel').update({
        'name': _customerName.text.toUpperCase(),
        'phone': phone,
        'status': deliveryStatusController.text,
      }).match({'tracking_id': tracking_id});

      print('Updated parcel successfully!');
    } catch (error) {
      // Handle the error appropriately

      // Log the error for debugging purposes
      print('Error updating parcel: $error');

      // Show a user-friendly error message
      print('Failed to update parcel. Please try again.');

      // You might want to reset the form or take other corrective actions
    }
  }

  // Future<void> deleteParcel() async {
  //   try {
  //     print('deleting parcel successfully');
  //     return;
  //   } catch (error) {
  //     print('Error deleting parcel: $error');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    initializevariables();

    ///Only for testing delete if this page is finalized
    getParcel();
    // _trackingNumber.text = tracking_id;
    print(_trackingNumber);
  }

  ///Only for testing delete if this page is finalized
  Future<void> getParcel() async {
    try {
      // await findParcel();
      setState(() {});
    } catch (error) {
      print('Error fetching parcel data: $error');
    }
  }

  @override
  void dispose() {
    super.dispose();
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
            'Edit Parcel',
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
              child: Column(
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: 220, // Adjusted width
                    height: 70, // Adjusted height
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
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
                                'Edit Parcel',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      enabled: false,
                                      controller: _trackingNumber,
                                      // enabled: true,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      maxLines: 1,
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .singleLineFormatter,
                                      ],
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color.fromARGB(255,
                                            249, 249, 249), // Background color
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please fill in';
                                        } else if (nameValid == false) {
                                          return 'Invalid Name';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: _customerName,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      maxLines: 1,
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .singleLineFormatter,
                                      ],
                                      decoration: InputDecoration(
                                        hintText: "enter customer name",
                                        filled: true,
                                        fillColor: const Color.fromARGB(255,
                                            249, 249, 249), // Background color
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 1.50,
                                            color: const Color(0xFFFFD233),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 10),
                                      ),
                                    ),
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

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

                          ///Delivery Status...............
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
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
                                                text: 'Delivery Status',
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
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                Container(
                                  width: 160,
                                  height: 60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 4, color: Color(0xFF333333)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: DropdownButton<String>(
                                    value: deliveryStatusController
                                        .text, // Default value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        deliveryStatusController.text =
                                            newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'waiting',
                                      'collected',
                                      'cancelled',
                                      'delivered'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  ///////////////////////////////////////
                  /////////////////////////////////////
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    InkWell(
                      onTap: () {
                        // Your code to handle the tap event
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: const Text('Confirm Delete?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No')),
                                    TextButton(
                                        onPressed: () async {
                                          await supabase
                                              .from('parcel')
                                              .delete()
                                              .eq('tracking_id', tracking_id);
                                          await getParcelList();
                                          //change snackbar design
                                          Navigator.pop(context);
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/admin_manageParcel',
                                              (route) => false);
                                          Fluttertoast.showToast(
                                            msg: "The parcel has been deleted!",
                                          );
                                        },
                                        child: const Text('Yes'))
                                  ],
                                ));
                      },
                      child: Container(
                        width: 180,
                        height: 53,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              width: 1.50,
                              color: Colors.red, // Border color
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
                                'Delete',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 15,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ),
                    ),
                    /////////////////////////
                    /////////////////////////
                    SizedBox(
                      width: 30.0,
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
                              phone = formatPhone(_phoneNumber.text);
                              phoneValid = await phone_check(phone!);
                              nameValid = await name_check(_customerName.text);
                              if (_formKey.currentState!.validate()) {
                                await updateParcel();
                                await getParcelList();
                                //change snackbar design
                                Fluttertoast.showToast(
                                  msg: "The parcel has been edited!",
                                );
                                Navigator.pushNamedAndRemoveUntil(context,
                                    '/admin_manageParcel', (route) => false);
                              } else {
                                print('cannot update');
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
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 15,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
