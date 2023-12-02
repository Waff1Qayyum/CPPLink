import 'package:cpplink/controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = supabase.auth
        .currentSession; //check if user already sign in by checking the session
    if (session != null) {
      final userID = supabase.auth.currentUser!.id;
      final checkAdmin =
          await supabase.from('admin').select().eq('user_id', userID);
      final checkRider =
          await supabase.from('rider').select().eq('user_id', userID);
      final checkCustomer =
          await supabase.from('user').select().eq('user_id', userID);

      if (checkAdmin.isNotEmpty) {
        print('User is an admin');
        await getAdminData(userID);
        await getUserList();
        Navigator.of(context).pushReplacementNamed('/admin_home');
      } else if (checkRider.isNotEmpty) {
        print('User is a rider');
        await getData(userID);
        Navigator.of(context).pushReplacementNamed('/rider_home');
      } else if (checkCustomer.isNotEmpty) {
        print('User is a customer');
        await getData(userID);
        Navigator.of(context).pushReplacementNamed('/customer_home');
      }
    } else {
      Navigator.of(context)
          .pushReplacementNamed('/login'); //go to user login page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LottieBuilder.asset('assets/yellow_loading.json'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
