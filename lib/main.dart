import 'package:cpplink/pages/home.dart';
import 'package:cpplink/pages/login.dart';
import 'package:cpplink/pages/register.dart';
import 'package:cpplink/pages/splashpage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://mhntlvugfhjbfkyxvcrl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1obnRsdnVnZmhqYmZreXh2Y3JsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc5NTcwNjYsImV4cCI6MjAxMzUzMzA2Nn0._ilDLH92hazhcg56G-OSmpykLpc2lSnh4NzXW4zX0YA',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      //for navigation to class in file.
      routes: <String, WidgetBuilder>{
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
