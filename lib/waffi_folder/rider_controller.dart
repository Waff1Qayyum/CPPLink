import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

var registerEmail;
var registerPassword;
var registerName;
var registerPhone;

String getEmail() {
  return registerEmail;
}

void setEmail(String email) {
  registerEmail = email;
}

String getPassword() {
  return registerPassword;
}

void setPassword(String password) {
  registerPassword = password;
}

String getName() {
  return registerName;
}

void setName(String name) {
  registerName = name;
}

String getPhone() {
  return registerPhone;
}

void setPhone(String phone) {
  registerPhone = phone;
}

Future<void> _signupRider(
    {required String email,
    required String phone,
    required String name,
    required String password}) async {
  final user = await supabase.auth.signUp(email: email, password: password);
  await supabase.from('user').insert({
    'user_id': user.user!.id,
    'email': email,
    'phone': phone,
    'name': name,
  });

  await supabase.from('rider').insert({'user_id': user.user!.id});
  final rider = await supabase
      .from('rider')
      .select('rider_id')
      .eq('user_id', user.user!.id)
      .single();
  final riderId = rider['rider_id'];
  await supabase
      .from('user')
      .update({'rider_id': riderId}).eq('user_id', user.user!.id);
}
