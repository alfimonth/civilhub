import 'package:flutter/material.dart';
import 'login.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100.0),
            Image.asset(
              'assets/logo.png', // Ganti dengan path ke logo Anda
              width: 100,
              height: 100,
            ),
            SizedBox(height: 16.0),
            Text(
              'Registrasi Civil Hub', // Ganti dengan nama aplikasi Anda
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32.0),
            // Form Email
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16.0),
            // Form Nama
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16.0),
            // Form Password
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            // Form Konfirmasi Password
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            // Tombol Registrasi
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk proses registrasi di sini
                String email = _emailController.text;
                String name = _nameController.text;
                String password = _passwordController.text;
                String confirmPassword = _confirmPasswordController.text;

                // Validasi input, misalnya pastikan email valid dan password sama dengan konfirmasi password
                if (_isValidEmail(email) &&
                    _isPasswordMatch(password, confirmPassword)) {
                  // Proses registrasi disini
                  // ...
                  // Setelah berhasil registrasi, pindah ke halaman lain misalnya halaman login
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                } else {
                  // Jika input tidak valid, bisa menampilkan pesan kesalahan atau memberikan notifikasi
                  // ...
                }
              },
              child: Text('Daftar'),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Link Registrasi
                TextButton(
                  onPressed: () {
                    // Tambahkan logika untuk pindah ke halaman registrasi
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text('Sudah punya akun? Login'),
                ),
                // SizedBox(width: 16.0),
                // // Link Lupa Password
                // TextButton(
                //   onPressed: () {
                //     // Tambahkan logika untuk pindah ke halaman lupa password
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) => ForgotPasswordScreen(),
                //     //   ),
                //     // );
                //   },
                //   child: Text('Lupa Password?'),
                // ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  bool _isValidEmail(String email) {
    // Validasi email menggunakan regular expression
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isPasswordMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}
