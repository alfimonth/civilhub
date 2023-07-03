import 'package:flutter/material.dart';
import 'login.dart';

class ForgotPasswordScreen extends StatelessWidget {
  void _showResetPasswordSentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email Terkirim'),
          content: Text('Periksa email anda untuk mereset password'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lupa Sandi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png', // Ganti dengan path ke logo Anda
              width: 100,
              height: 100,
            ),
            SizedBox(height: 16.0),
            // Form Email
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 32.0),
            // Tombol Submit
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk mengirim email lupa sandi di sini
                _showResetPasswordSentDialog(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
