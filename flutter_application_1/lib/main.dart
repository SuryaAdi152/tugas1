import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart'; // Import HomePage di sini

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // Menghilangkan logo debug
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/register', // Halaman awal saat aplikasi dijalankan
      routes: {
        '/login': (context) => LoginPage(), // Rute ke LoginPage
        '/register': (context) => RegisterPage(), // Rute ke RegisterPage
        '/home': (context) => HomePage(email: ''), // Rute ke HomePage, diisi kosong untuk contoh
      },
    );
  }
}
