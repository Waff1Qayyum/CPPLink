import 'package:cpplink/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  static bool loggedout = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    if (loggedout == true) {
      Future(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You have successfully logged out'),
            backgroundColor: Colors.green[400],
          ),
        );
        loggedout = false; // Reset the flag
      });
    }
    super.initState();
  }

  Future<String?> userLogin({
    required final String email,
    required final String password,
  }) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = supabase.auth.currentUser?.id;
      return user;
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid Login Detail'),
        backgroundColor: Colors.red[400],
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Unexpected Error Occured"),
        backgroundColor: Colors.red[400],
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
