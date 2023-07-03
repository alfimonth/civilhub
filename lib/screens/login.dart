import 'package:civilhub/main.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'forgot.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Login Civil Hub', // Ganti dengan nama aplikasi Anda
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32.0),
            // Form Email
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16.0),
            // Form Password
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            // Tombol Login
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
                // Tambahkan logika untuk proses login di sini
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Link Registrasi
                TextButton(
                  onPressed: () {
                    // Tambahkan logika untuk pindah ke halaman registrasi
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationScreen(),
                      ),
                    );
                  },
                  child: Text('Belum punya akun? Registrasi'),
                ),
                SizedBox(width: 16.0),
                // Link Lupa Password
                TextButton(
                  onPressed: () {
                    // Tambahkan logika untuk pindah ke halaman lupa password
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text('Lupa Password?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
