// import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';
import 'controller.dart';
import 'main.dart';

class CustomerRegisterPage extends StatefulWidget {
  const CustomerRegisterPage({super.key});

  @override
  State<CustomerRegisterPage> createState() => _CustomerRegisterPageState();
}

class _CustomerRegisterPageState extends State<CustomerRegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool? emailUnique;
  bool? phoneUnique;
  bool? phoneValid;
  bool checked = false;
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  bool? _phoneValid() {
    if (!RegExp(r'^\d{10,11}$').hasMatch(_phoneController.text)) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> _signUp() async {
    try {
      if (RegisterUserType == 'rider') {
        //Set Rider details
        registerEmail = _emailController.text;
        registerPassword = _passwordController.text;
        registerName = _nameController.text;
        registerPhone = _phoneController.text;
        print('rider details saved');
        return;
      }
      final res = await supabase.auth.signUp(
          email: _emailController.text,
          password: _passwordController.text,
          emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/');
      await supabase.from('user').insert({
        'user_id': res.user!.id,
        'name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
      });
      print('created successfully');
      return;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Unexpected Error Occurred')));
    }
  }

  Future<bool> _emailUnique() async {
    final _email = await supabase
        .from('user')
        .select('email')
        .eq('email', _emailController.text)
        .limit(1);

    if (_email.isNotEmpty && _email[0]['email'] != null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> _phoneUnique() async {
    final phoneNo = await supabase
        .from('user')
        .select('phone')
        .eq('phone', _phoneController.text)
        .limit(1);
    if (phoneNo.isNotEmpty && phoneNo[0]['phone'] != null) {
      return false;
    } else {
      return true;
    }
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
            'Register',
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
              Navigator.of(context).pushReplacementNamed('/register_type');
            },
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60.0,
                ),
                Container(
                  height: 42.0,
                  width: 235.0,
                  child: Container(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Register to',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Montagu Slab',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  )),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                SizedBox(height: 50.0),
                /////Input Column
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(180, 221, 221,
                        221), // Semi-transparent black background
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            ///////////////////////////////////////////
                            Column(
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
                                        color:
                                            Color.fromARGB(164, 117, 117, 117),
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
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                      hintText: "enter full name",
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
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Color(0xFFFFD233),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            ///input mobile number
                            SizedBox(height: 20),
                            Column(
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
                                        color:
                                            Color.fromARGB(164, 117, 117, 117),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter mobile number';
                                      } else if (phoneUnique == false) {
                                        return 'Mobile number already exist';
                                      } else if (phoneValid == false) {
                                        return "Enter Valid Phone Number";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _phoneController,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                      hintText: "enter mobile number",
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
                                      prefixIcon: Icon(
                                        Icons.call,
                                        color: Color(0xFFFFD233),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),

                            /// input email
                            SizedBox(height: 20),
                            Column(
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
                                        color:
                                            Color.fromARGB(164, 117, 117, 117),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: _emailController,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                      hintText: "enter email",
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
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Color(0xFFFFD233),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an email';
                                      } else if (emailUnique == false) {
                                        return 'Email Already Exist';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),

                            ///input password
                            SizedBox(height: 20),
                            Column(
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
                                        color:
                                            Color.fromARGB(164, 117, 117, 117),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                      hintText: "enter password",
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
                                      prefixIcon: Icon(
                                        Icons.password,
                                        color: Color(0xFFFFD233),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a password';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),

                            ///input confirm password
                            SizedBox(height: 20),
                            Column(
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
                                        color:
                                            Color.fromARGB(164, 117, 117, 117),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: _confirmPasswordController,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                      hintText: "enter confirm password",
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
                                      prefixIcon: Icon(
                                        Icons.password,
                                        color:
                                            Color.fromARGB(255, 255, 210, 51),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a confirm password';
                                      } else if (_passwordController.text !=
                                          _confirmPasswordController.text) {
                                        _passwordController.clear();
                                        _confirmPasswordController.clear();
                                        return "Password does not match";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: 263,
                              height: 37,
                              decoration: ShapeDecoration(
                                color: Color(0xFFFFD233),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  emailUnique = await _emailUnique();
                                  phoneUnique = await _phoneUnique();
                                  phoneValid = await _phoneValid();
                                  if (_formkey.currentState!.validate()) {
                                    _signUp();
                                    if (RegisterUserType == 'rider') {
                                      print('go to vehicle page');
                                      Navigator.pushNamed(
                                          context, '/rider_vehicle');
                                    } else {
                                      print('go to login page');
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/login', (route) => false);
                                    }
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                child: Text(
                                    isLoading == false
                                        ? 'Register'
                                        : 'Loading..',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w700,
                                    )),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFFFFD233)),
                                ),
                              ),
                            ),
                            //////////////////////////////////////////
                          ],
                        ),
                      )),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?  ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: Text(
                          'Sign in now',
                          style: TextStyle(
                            color: Color(0xFFFFD233),
                            fontSize: 12,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        )),
                  ],
                ),

                ///end
              ],
            ),
          ],
        ),
      ),
    );
  }
}
