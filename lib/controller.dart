import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'main.dart';

/////////////////
// final currentUser =  supabase.auth.currentUser;
// final currentID = currentUser!.id;
// final currentUName =  supabase.from('user').select('name').eq('user_id',currentID);

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

Future<dynamic> signupRider() async {
  try {
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
  } catch (e) {
    return;
  }
}

//Validation

//phone validation
bool phone_check(String phone) {
  if (!RegExp(r'^01\d{8,9}$').hasMatch(phone)) {
    return false;
  } else {
    return true;
  }
}

//name validation
bool name_check(String name) {
  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
    return false;
  } else {
    return true;
  }
}

//email validation
bool email_check(String email) {
  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
      .hasMatch(email)) {
    return false;
  } else {
    return true;
  }
}

//name of user exist
Future<bool> user_exist(String name) async {
  final user = await supabase.from('user').select('name').eq('name', name);

  if (user.isEmpty || user == null) {
    return false;
  } else {
    return true;
  }
}

//formatting

//format phone
String formatPhone(String phone) {
  return phone.replaceAll(RegExp(r'\s+'), '').trim();
}

//format name
String formatName(String name) {
  return name.replaceAll(RegExp(r'\s+'), ' ').trim().toUpperCase();
}

//format email
String formatEmail(String email) {
  return email.trim();
}

//store information(user)
String getID() {
  return supabase.auth.currentUser!.id;
}

var user_name;
var user_phone;
var user_email;
var user_picture;
var picture;
var vehicle_url;
var vehicle_picture;
var user_parcel = <String>[];

Future<void> getData(dynamic id) async {
  final data = await supabase
      .from('user')
      .select('name, phone, email, picture_url')
      .eq('user_id', id)
      .single();

  final parcel = await supabase
      .from('parcel')
      .select('tracking_id')
      .eq('user_id', id)
      .eq('status', 'arrived');
  if (parcel != null) {
    for (int i = 0; i < parcel.length; i++) {
      user_parcel.add(parcel[i]['tracking_id']);
    }
  }

  user_name = data['name'];
  user_phone = data['phone'];
  user_email = data['email'];
  user_picture = data['picture_url'];

  if (user_picture != null) {
    picture = Image.network(
      user_picture!,
      fit: BoxFit.cover,
      width: 70,
      height: 70,
    );
  }

  final rider =
      await supabase.from('user').select('rider_id').eq('user_id', id).single();

  if (rider['rider_id'] != null) {
    getVehiclePicture(id);
  }
}

void getVehiclePicture(dynamic id) async {
  final data = await supabase
      .from('rider')
      .select('picture_url')
      .eq('user_id', id)
      .single();

  vehicle_url = data['picture_url'];

  if (vehicle_url != null) {
    vehicle_picture = Image.network(
      vehicle_url!,
      fit: BoxFit.cover,
      width: 70,
      height: 70,
    );
  }
}

//phone unique
Future<bool> phone_unique(String phone) async {
  final phoneNo =
      await supabase.from('user').select('phone').eq('phone', phone).limit(1);
  if (phoneNo.isNotEmpty && phoneNo[0]['phone'] != null) {
    return false;
  } else {
    return true;
  }
}

//store information(admin)
var admin_name;
var admin_phone;
var admin_email;
var admin_picture;
var picture_url;
Future<void> getAdminData(dynamic id) async {
  final data = await supabase
      .from('admin')
      .select('name, phone, email, picture_url')
      .eq('user_id', id)
      .single();

  admin_name = data['name'];
  admin_phone = data['phone'];
  admin_email = data['email'];
  picture_url = data['picture_url'];

  if (picture_url != null) {
    admin_picture = Image.network(
      picture_url!,
      fit: BoxFit.cover,
      width: 70,
      height: 70,
    );
  }
}

///////////////////
///////////////////
//selected parcel
var tracking_id;
var customerName;
var customerNumber;
var dateArrived;
var status;
var selectedValue;
// var searchParcel = 'JEG3412';

// final mydata = findParcel(parcelData);
Future<void> findParcel(dynamic searchParcel) async {
  try {
    final parcelData = await supabase
        .from('parcel')
        .select()
        .eq('tracking_id', searchParcel)
        .single();

    if (parcelData != null) {
      tracking_id = parcelData['tracking_id'];
      customerName = parcelData['name'];
      customerNumber = parcelData['phone'];
      dateArrived = parcelData['date_arrived'];
      status = parcelData['status'];

      print('my track id is $tracking_id and the status is $status');
    } else {
      // Handle the case where parcelData is null (e.g., parcel not found)
      print('Parcel not found for tracking_id: $searchParcel');
    }
  } catch (error) {
    // Handle errors during data retrieval
    print('Error fetching parcel data: $error');
  }
}

//List of elements
var user_data;
var parcel_data;
var requested_parcel;

Future<void> getUserList() async {
  user_data = await supabase.from('user').select<PostgrestList>();
}

Future<void> getParcelList() async {
  parcel_data = await supabase.from('parcel').select<PostgrestList>();
}

Future<void> getRequestedParcelList() async {
  requested_parcel = await supabase.from('booking').select<PostgrestList>();
}

//update parcel data
var edit_parcel;

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
var riderMode = false;

//parcel unique
Future<bool> parcel_unique(String parcelId) async {
  final parcel = await supabase
      .from('parcel')
      .select()
      .eq('tracking_id', parcelId)
      .limit(1);

  if (parcel.isNotEmpty && parcel[0]['phone'] != null) {
    return false;
  } else {
    return true;
  }
}
