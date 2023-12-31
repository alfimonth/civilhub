import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';
import 'screens/login.dart';
import 'helpers/user_info.dart'; // Ganti dengan halaman utama aplikasi Anda

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  var token = UserInfo().getToken();

  void _startTimer() {
    Timer(Duration(seconds: 3), () async {
      var token = await UserInfo().getToken();

      if (token != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Ganti dengan path ke logo Anda
              width: 100,
              height: 100,
            ),
            SizedBox(height: 16),
            Text(
              'Civil Hub', // Ganti dengan judul aplikasi Anda
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
