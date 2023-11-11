import 'package:cpplink/customer_pages/customer_updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'admin_pages/admin_homepage.dart';
import 'customer_pages/customer_changeName.dart';
import 'customer_pages/customer_changePassword.dart';
import 'customer_pages/customer_hompage.dart';
import 'customer_pages/customer_register.dart';
import 'otpVerification.dart';
import 'forgotPassword.dart';
import 'resetPassword.dart';
import 'login_page.dart';
import 'rider_pages/rider_homepage.dart';
import 'splash.dart';
import 'package:uni_links/uni_links.dart';


Future<void> main() async {
  await Supabase.initialize(
      url: 'https://bzscuwrolzmocdshaemx.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6c2N1d3JvbHptb2Nkc2hhZW14Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTkzNTE3MDksImV4cCI6MjAxNDkyNzcwOX0.iGlxlb_WNLjh2apj3u9DDkvfl7d8hChLgd2qrIj6JJk',);
  runApp(MyApp());
}

void clearUserSession() {
  supabase.auth.signOut();
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    clearUserSession();

    return MaterialApp(
      title: 'CPP Link',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', //used for changing between pages
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/register': (_) => const CustomerRegisterPage(),
        '/login': (_) => const LoginPage(), //login_page

////////////////////users homepage////////////////
        '/admin_home': (_) => const AdminHomePage(),
        '/rider_home': (_) => const RiderHomePage(),
        '/customer_home': (_) => const CustomerHomepage(),

////////////////////reset password homepage////////////////
        '/forgotPassword': (_) => const ForgotPassword(),
        '/otpVerification': (_) => const OTPVerification(),
        '/resetPassword': (_) => const ResetPassword()


      },
    );
  }
}
