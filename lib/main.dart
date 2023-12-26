import 'package:cpplink/admin_pages/admin_updateProfille.dart';
import 'package:cpplink/customer_pages/customer_quickScan.dart';
import 'package:cpplink/customer_pages/customer_updateProfile.dart';
import 'package:cpplink/customer_register.dart';
import 'package:cpplink/rider_pages/rider_changeProfilePicture.dart';
import 'package:cpplink/rider_pages/rider_uploadVehicle.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//////////admin////////////
import 'admin_pages/admin_changeName.dart';
import 'admin_pages/admin_changePassword.dart';
import 'admin_pages/admin_changePhoneNumber.dart';
import 'admin_pages/admin_changeProfilePicture.dart';
import 'admin_pages/admin_homepage.dart';
import 'admin_pages/admin_manageParcel.dart';
import 'admin_pages/admin_registerParcel.dart';
import 'admin_pages/admin_updatetParcel.dart';
import 'customer_pages/customer_bookingPage.dart';
//////customer/////////
import 'customer_pages/customer_changeName.dart';
import 'customer_pages/customer_changePassword.dart';
import 'customer_pages/customer_changePhoneNumber.dart';
import 'customer_pages/customer_changeProfilePicture.dart';
import 'customer_pages/customer_checkParcel.dart';
import 'customer_pages/customer_hompage.dart';
import 'customer_pages/customer_riderPage.dart';
import 'forgotPassword.dart';
//////////main files////////
import 'login_page.dart';
import 'otpVerification.dart';
import 'registerType_page.dart';
import 'resetPassword.dart';
import 'rider_pages/delivery_deliveryList.dart';
import 'rider_pages/delivery_homepage.dart';
import 'rider_pages/delivery_proof.dart';
///////////rider////////////
import 'rider_pages/rider_changeName.dart';
import 'rider_pages/rider_changePassword.dart';
import 'rider_pages/rider_changePhoneNumber.dart';
import 'rider_pages/rider_changeVehicle.dart';
import 'rider_pages/rider_homepage.dart';
import 'rider_pages/rider_updateProfile.dart';
import 'splash.dart';

Future<void> main() async {
  await Supabase.initialize(
      // url: 'https://bzscuwrolzmocdshaemx.supabase.co',
      // anonKey:
      //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6c2N1d3JvbHptb2Nkc2hhZW14Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTkzNTE3MDksImV4cCI6MjAxNDkyNzcwOX0.iGlxlb_WNLjh2apj3u9DDkvfl7d8hChLgd2qrIj6JJk');
      url: 'https://pzwswqqczazxllateqgd.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6d3N3cXFjemF6eGxsYXRlcWdkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk3NjMyNjAsImV4cCI6MjAxNTMzOTI2MH0.8ASy9AfdIPx0S58eI5WZqaCktGY8_vC30M9mqtkDaFU');
  runApp(MyApp());
}

void clearUserSession() {
  supabase.auth.signOut();
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // clearUserSession();

    return MaterialApp(
      title: 'CPP Link',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', //used for changing between pages
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(), //login_page

////////////////////register page////////////////
        '/register_type': (_) => const RegisterTypePage(), //login_page
        '/customer_registration': (_) => const CustomerRegisterPage(),

////////////////////users homepage////////////////

        //admin
        '/admin_home': (_) => const AdminHomePage(),
        '/admin_profile': (_) => const AdminProfile(),
        '/admin_changeName': (_) => const AdminChangeName(),
        '/admin_changePw': (_) => const AdminChangePassword(),
        '/admin_changePFP': (_) => const AdminChangePicture(),
        '/admin_changePhone': (_) => const AdminChangePhone(),
        '/admin_manageParcel': (_) => const AdminManageParcel(),
        '/admin_updateParcel': (_) => const AdminUpdateParcel(),
        '/admin_registerParcel': (_) => const AdminRegisterParcel(),

        //customer
        '/customer_home': (_) => const CustomerHomepage(),
        '/customer_profile': (_) => const CustomerProfile(),
        '/changeName': (_) => const CustomerChangeName(),
        '/changePw': (_) => const CustomerChangePassword(),
        '/changePFP': (_) => const CustomerChangePicture(),
        '/changePhone': (_) => const CustomerChangePhone(),
        '/customer_booking': (_) => const customerBooking(),
        '/customer_myRider': (_) => const customerRiderPage(),
        '/customer_checkParcel': (_) => const customerCheckParcel(),
        '/customer_quickScan': (_) => const customerQuickScan(),

        // rider
        '/rider_home': (_) => const RiderHomePage(),
        '/rider_changeName': (_) => const RiderChangeName(),
        '/rider_changePw': (_) => const RiderChangePassword(),
        '/rider_changePFP': (_) => const RiderChangePicture(),
        '/rider_changePhone': (_) => const RiderChangePhone(),

        '/rider_profile': (_) => const RiderChangeProfile(),
        '/rider_changeVehicle': (_) => const RiderChangeVehicle(),
        '/rider_vehicle': (_) => const RiderUploadVehicle(),

        '/delivery_homepage': (_) => const DeliveryHomePage(),
        '/delivery_list': (_) => const DeliveryList(),
        '/delivery_proof': (_) => const DeliveryProof(),

//////////////////forgot password//////////////////
        '/forgotPassword': (_) => const ForgotPassword(),
        '/otpVerification': (_) => const OTPVerification(),
        '/resetPassword': (_) => const ResetPassword(),

//////////////////user_updateProfile//////////////////
      },
    );
  }
}
