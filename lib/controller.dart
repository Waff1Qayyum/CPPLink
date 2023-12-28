import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'main.dart';

/////////////////
// final currentUser =  supabase.auth.currentUser;
// final currentID = currentUser!.id;
// final currentUName =  supabase.from('user').select('name').eq('user_id',currentID);
final currentuser = supabase.auth.currentSession!.user.id;

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
var user_booking = <String>[];
var user_parcel = <String>[];
var show_row; //show button 'My booking' in homepage
var user_booking_data;
var user_booking_address;
var selectedValue;

dynamic pass_booking_data;

//booking rider
var rider;
var rider_name;
var rider_vehicleType;
var rider_plate;
var rider_model;
var rider_color;
bool? rider_exist;
bool? delivered;
//'show rider details in customer_myrider'

Future<void> getData(dynamic id) async {
  user_booking = <String>[]; //reset list
  user_parcel = <String>[];
  selectedValue = null;
  rider_exist = false;
  delivered = false;

//get user detail
  final data = await supabase
      .from('user')
      .select('name, phone, email, picture_url')
      .eq('user_id', id)
      .single();

  user_name = data['name'];
  user_phone = data['phone'];
  user_email = data['email'];
  user_picture = data['picture_url'];

//get user picture
  if (user_picture != null) {
    picture = Image.network(
      user_picture!,
      fit: BoxFit.cover,
      width: 70,
      height: 70,
    );
  }
  //get rider detail
  rider = await supabase.from('user').select().eq('user_id', id).single();

  //get rider picture
  if (rider['rider_id'] != null) {
    getVehiclePicture(id);
  }

//select all customer parcel with 'arrived' status to display
  getArrivedParcel(id);

//get customer parcel delivery request with 'accepted' or 'request' status
  final booking_data = await supabase
      .from('booking')
      .select()
      .eq('customer_id', id)
      .or('booking_status.eq.request, booking_status.eq.accepted');
  //if exist request
  if (booking_data != null && booking_data.isNotEmpty) {
    show_row = true;
    for (int i = 0; i < booking_data.length; i++) {
      //store the parcel ID  into user_booking array
      user_booking.add(booking_data[i]['parcel_id']);
    }
    //store the parcel address
    user_booking_address = booking_data[0]['address'];
    pass_booking_data = booking_data;
  } else {
    //if request not exist
    show_row = false;
    print("no request for this id");
  }
  //get rider details
  getRiderDetail(id);
}

Future<void> getRiderDetail(dynamic id) async {
  //get customer parcel delivery request with 'accepted' or 'request' status
  final booking_data = await supabase
      .from('booking')
      .select()
      .eq('customer_id', id)
      .or('booking_status.eq.request, booking_status.eq.accepted');
  //if request exist and already have a rider ID
  if (booking_data != null &&
      booking_data.isNotEmpty &&
      booking_data[0]['rider_id'] != null) {
    final rider_data = await supabase
        .from('rider')
        .select('*, user:user_rider_id_fkey(name, user_id)')
        .eq('rider_id', booking_data[0]['rider_id'])
        .single();

    //get the detail
    rider_name = rider_data['user'][0]['name'];
    rider_vehicleType = rider_data['vehicle_type'];
    rider_plate = rider_data['plate_number'];
    rider_model = rider_data['vehicle_model'];
    rider_color = rider_data['vehicle_colour'];
    await getVehiclePicture(rider_data['user'][0]['user_id']);
    print('RIDER_NAME : ' + rider_name);
    rider_exist = true;
    print("In function " + rider_exist.toString());
  } else {
    rider_exist = false;
    print('NO RIDER');
    print("In function " + rider_exist.toString());
  }
}

//Check the booking made status, is it delivered or still waiting
Future<void> checkBookingStatus(dynamic id) async {
  bool allDelivered = false;
  //CHECK for the requested
  for (int i = 0; i < user_booking.length; i++) {
    //CHECK IF BOOKING HAS BEEN DELIVERED
    final delivered_booking = await supabase
        .from('booking')
        .select()
        .eq('customer_id', id)
        .eq('parcel_id', user_booking[i])
        .eq('booking_status', 'delivered');

//if the request is delivered
    if (delivered_booking.isNotEmpty && delivered_booking != null) {
      print('THE STATUS FOR PARCEL ID : ' +
          user_booking[i] +
          ' IS ' +
          delivered_booking[0]['booking_status']);
      allDelivered = true;
      print('Booking matched and Parcel is delivered!');
      print('delivered : ' + delivered.toString());
    } else {
      print('No Booking matched with this id ' + user_booking[i]);
      print('delivered : ' + delivered.toString());
      allDelivered = false;
      break;
    }
  }
  //will remove the Mybooking button, remove rider, exit from riderpage
  if (allDelivered == true) {
    show_row = false;
    rider_exist = false;
    delivered = true;
  }
}

//check if new parcel arrived for a specific user
Future<void> getArrivedParcel(dynamic id) async {
  user_parcel = <String>[];
//select all customer parcel with 'arrived' status to display
  final parcel = await supabase
      .from('parcel')
      .select('tracking_id')
      .eq('user_id', id)
      .eq('status', 'arrived');
  if (parcel != null) {
    for (int i = 0; i < parcel.length; i++) {
      //store track id in user_parcel array
      user_parcel.add(parcel[i]['tracking_id']);
    }
  }
}

Future<void> getVehiclePicture(dynamic id) async {
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

//check request or accept parcel
Future<bool> validateBooking(dynamic id) async {
  final book = await supabase
      .from('booking')
      .select()
      .eq('customer_id', id)
      .or('booking_status.eq.request, booking_status.eq.accepted');

  if (book.isEmpty || book == null) {
    return true;
  } else {
    return false;
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
var rider_parcel_list;
var all_rider_parcel_list;
var all_rider_details;
var user_rider;
var group_parcel;

Future<void> getUserList() async {
  user_data = await supabase.from('user').select();
}

Future<void> getParcelList() async {
  parcel_data = await supabase.from('parcel').select();
}

Future<void> getRequestedParcelList() async {
  requested_parcel = await supabase
      .from('booking')
      .select()
      .or('booking_status.eq.request, booking_status.eq.cancelled');
}

Future<void> groupParcel() async {
  var test = groupBy(requested_parcel, (Map p) => p['customer_id']);

  group_parcel = test.entries.map((e) => e).toList();
}

Future<void> getRiderParcel(dynamic id) async {
  rider_parcel_list = await supabase
      .from('booking')
      .select('*, parcel(name, tracking_id)')
      .eq('rider_id', id);
}

Future<void> getAllRiderParcel() async {
  // all_rider_parcel_list = await supabase.from('rider').select<PostgrestList>();
  all_rider_parcel_list = await supabase.from('rider').select(
      'status, rider_id,booking(parcel_id,booking_status),user:user_id(name,phone)');
}

//for checking if Customer change into rider mode
dynamic riderMode;
Future<void> getRiderStatus() async {
  final currentUser = supabase.auth.currentUser!.id;
  user_rider = await supabase.from('rider').select().eq('user_id', currentUser);

  if (user_rider[0]['status'] != 'false') {
    riderMode = true;
  } else {
    riderMode = false;
  }
}

Future<void> updateRiderStatus(String riderID, String status) async {
  await supabase
      .from('rider')
      .update({'status': status}).eq('rider_id', riderID);
}

//update parcel data
var edit_parcel;

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

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

//
var booking_index;

//for autocomplete
List<String> list_name = <String>[];
List<String> list_phone = <String>[];
dynamic list_user;

Future<void> userNameList() async {
  list_name = [];
  list_phone = [];

  list_user = await supabase.from('user').select('name, phone');

  dynamic name = list_user.map((element) => element['name'] as String).toList();
  dynamic phone =
      list_user.map((element) => element['phone'] as String).toList();

  for (String s in name) {
    list_name.add(s);
  }

  for (String s in phone) {
    list_phone.add(s);
  }
}

////////////////////////
///////////////////////

final currentUserID = supabase.auth.currentSession!.user.id;
