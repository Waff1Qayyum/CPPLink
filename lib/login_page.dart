import 'package:flutter/material.dart';
import 'package:parcelink/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; //comment

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool? emailInvalid;
  bool? passwordInvalid;
  bool? workornot;

  Future<bool?> _emailError() async {
    final data = await supabase
        .from('user')
        .select('email')
        .eq('email', _emailController.text)
        .limit(1);
    if (data.isNotEmpty && data[0] != null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool?>? _passwordError() async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (response.user?.id != null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return true;
    }
  }

  Future userLogin() async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Unexpected Error Occured"),
        backgroundColor: Colors.red[400],
      ));
      _emailController.clear();
      _passwordController.clear();
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
                      child: Form(
                        key: _formKey,
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
                                      if (value!.isEmpty) {
                                        return 'Please enter an email';
                                      } else if (emailInvalid == true) {
                                        return 'Email do not exist';
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
                                      if (value!.isEmpty) {
                                        return 'Please enter a password';
                                      } else if (passwordInvalid == true &&
                                          emailInvalid == false) {
                                        return 'Wrong Password';
                                      } else {
                                        return null;
                                      }
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
                                  emailInvalid = await _emailError();
                                  passwordInvalid = await _passwordError();
                                  if (_formKey.currentState!.validate()) {
                                    userLogin();
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/custHome', (route) => false);
                                  }
                                  ;
                                  setState(() {
                                    isLoading = false;
                                  });
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
