import 'package:flutter/material.dart';
import 'package:cpplink/customer_pages/customer_hompage.dart';
import 'package:cpplink/login_page.dart';
import 'package:cpplink/splash.dart';
// import 'package:parcelink/waffi_folder/register.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'customer_pages/customer_register.dart';
// import 'login_page.dart';
import 'splash.dart';
// import 'waffi_folder/home.dart';
// import 'waffi_folder/login.dart';
// import 'waffi_folder/register.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: 'https://bzscuwrolzmocdshaemx.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6c2N1d3JvbHptb2Nkc2hhZW14Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTkzNTE3MDksImV4cCI6MjAxNDkyNzcwOX0.iGlxlb_WNLjh2apj3u9DDkvfl7d8hChLgd2qrIj6JJk');
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CPP Link',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', //used for changing between pages
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/register': (_) => const CustomerRegisterPage(),
        '/login': (_) => const LoginPage(), //login_page
        '/custHome': (_) => const CustomerHomepage(),
        // '/account': (_) => const AccountPage(),

////////////////for testing purpose//////////
        // '/login': (_) => const CustomerHomepage(), //check customer homepage
        // '/login': (_) => const AdminHomePage(), //check customer homepage
      },
    );
  }
}
