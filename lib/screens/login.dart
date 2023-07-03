import 'package:civilhub/main.dart';
import 'package:flutter/material.dart';
import '../services/login_service.dart';
import 'register.dart';
import 'forgot.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      String username = _usernameController.text;
      String password = _passwordController.text;

      LoginService loginService = LoginService();
      bool isLoggedIn = await loginService.login(username, password);

      if (isLoggedIn) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Gagal'),
              content: Text('Username atau password salah. Silakan coba lagi.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height,
            child: FormBuilder(
              key: _formKey,
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
                  FormBuilderTextField(
                    name: 'email',
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.email(context),
                    ]),
                  ),
                  SizedBox(height: 16.0),
                  // Form Password
                  FormBuilderTextField(
                    name: 'password',
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: FormBuilderValidators.required(context),
                  ),
                  SizedBox(height: 32.0),
                  // Tombol Login
                  ElevatedButton(
                    onPressed:
                        _login, // Menggunakan method _login sebagai handler onPress
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
          ),
        ),
      ),
    );
  }
}
