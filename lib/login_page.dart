import 'dart:async';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
<<<<<<< Updated upstream
=======
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool redirecting = false;
  bool? emailInvalid;
  bool? passwordInvalid;
  bool? workornot;
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  Future<bool?> _emailError() async {
    final checkAdmin = await supabase
        .from('admin')
        .select('email')
        .eq('email', _emailController.text);
    final checkRider = await supabase
        .from('rider')
        .select('email')
        .eq('email', _emailController.text);
    final checkCustomer = await supabase
        .from('user')
        .select('email')
        .eq('email', _emailController.text);
    if (checkAdmin.isNotEmpty || checkRider.isNotEmpty || checkCustomer.isNotEmpty) {
      print("email okay");
      return true;
    } else {
      print("error");
      return false;
    }
  }

  Future<bool?>? _passwordError() async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (response.user!.id.isNotEmpty) {
        print("pass okay");
        return false;
      } else {
        print("pass not okay");
        return true;
      }
    } catch (e) {
      return true;
    }
  }

  Future userLogin() async {
    try {
      setState(() {
        isLoading = true;
      });
      await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (mounted) {
        //login successfully
        print("login successs");
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signin failed: ${error.message}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

>>>>>>> Stashed changes
  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (redirecting) return;
      final session = data.session;
      if (session != null) {
        redirecting = true;
        print("redirecting");
        Navigator.of(context).pushReplacementNamed('/');
      }
    });
    super.initState();
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
            'Sign In',
            style: TextStyle(
              fontFamily: 'roboto',
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 120.0,
                ),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 190,
                          child: Image.asset(
                              'images/cpp_logo.png'), // Replace 'your_image.png' with the actual image file name
                        ),
                      ]),
                ),
                /////Input Column
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(180, 221, 221,
                        221), // Semi-transparent black background
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
/////////////////////////////////////////////
                          /// input email
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
                                      color: Color.fromARGB(164, 117, 117, 117),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    hintText: "enter email",
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
                                      Icons.email,
                                      color: Color(0xFFFFD233),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    return null;
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
                                      color: Color.fromARGB(164, 117, 117, 117),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    hintText: "enter password",
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
                                    if (value!.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: 40),
                          Container(
                            width: 263,
                            height: 37,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFFD233),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
<<<<<<< Updated upstream
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
                              onPressed: () {},
                              child: Text('Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w700,
                                  )),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFFFD233)),
=======
                              child: ElevatedButton(
                                onPressed: () async {
                                  // setState(() {
                                  //   isLoading = true;
                                  // });
                                  emailInvalid = await _emailError();
                                  passwordInvalid = await _passwordError();
                                  if (_formKey.currentState!.validate()) {
                                    userLogin();
                                  }
                                },
                                child: Text(
                                    isLoading == false
                                        ? 'Sign In'
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
>>>>>>> Stashed changes
                              ),
                            ),
                          ),
//////////////////////////////////////////
                        ],
                      )),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Do not have an account?  ',
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
                          Navigator.of(context)
                              .pushReplacementNamed('/register');
                        },
                        child: Text(
                          'Register now',
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
