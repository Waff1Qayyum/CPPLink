import 'main.dart';

/////////////////////////
//////////////////////// for otp
var email; // for otp
void setEmail(String _email) {
  email = _email;
}

String getEmail() {
  return email;
}

/////////////////////////
//////////////////////// for register rider
var RegisterUserType;
var registerEmail;
var registerPassword;
var registerName;
var registerPhone;

String getRiderEmail() {
  return registerEmail;
}

void setRiderEmail(String email) {
  registerEmail = email;
}

String getRiderPassword() {
  return registerPassword;
}

void setRiderPassword(String password) {
  registerPassword = password;
}

String getRiderName() {
  return registerName;
}

void setRiderName(String name) {
  registerName = name;
}

String getRiderPhone() {
  return registerPhone;
}

void setRiderPhone(String phone) {
  registerPhone = phone;
}

Future<dynamic> signupRider(
    // var email,
    // var phone,
    // var name,
    // var password,
    ) async {
  final user = await supabase.auth.signUp(
      email: registerEmail,
      password: registerPassword,
      emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/');
  await supabase.from('user').insert({
    'user_id': user.user!.id,
    'email': registerEmail,
    'phone': registerPhone,
    'name': registerName,
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

  return user.user?.id;
}


//////////////////// rider 
///////////////////