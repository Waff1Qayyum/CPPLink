import 'package:cpplink/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool? pnoUnique;
  bool? emailUnique;
  bool isLoading = false;

  bool? phoneValid() {
    if (!RegExp(r'^\d{10,11}$').hasMatch(_phoneController.text)) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> phoneUnique() async {
    final phoneNo = await supabase
        .from('User')
        .select('phone_no')
        .eq('phone_no', _phoneController.text)
        .limit(1);
    if (phoneNo.isNotEmpty && phoneNo[0]['phone_no'] != null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> _emailUnique() async {
    final _email = await supabase
        .from('User')
        .select('email')
        .eq('email', _emailController.text)
        .limit(1);
    if (_email.isNotEmpty && _email[0]['email'] != null) {
      return false;
    } else {
      return true;
    }
  }

  void signUp() async {
    final AuthResponse res = await supabase.auth.signUp(
      email: _emailController.text,
      password: _passwordController.text,
    );
    await supabase.from('User').insert({
      'id': res.user!.id,
      'email': _emailController.text,
      'name': _nameController.text,
      'phone_no': _phoneController.text
    });
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
