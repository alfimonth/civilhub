import 'package:flutter/material.dart';
import 'account_screen.dart';
import '../main.dart';

class ChangePasswordScreen extends StatelessWidget {
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
                  MaterialPageRoute(builder: (context) => AccountScreen()),
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
        title: Text('Ubah Sandi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false,
            );
          },
        ),
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
            // Nama Aplikasi
            Text(
              'Masukkan password lama anda, kami akan mengirimkan link untuk mereset password ke email anda', // Ganti dengan nama aplikasi Anda
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 32.0),
            // Form Email
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
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
