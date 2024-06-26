import 'package:flutter/material.dart';
import 'package:flutter_application_1/add_user.dart';
import 'package:flutter_application_1/list_user.dart';
import 'package:get_storage/get_storage.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart'; 

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // ini kode buat ngilangin logo debug
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login', // 
      routes: {
        '/login': (context) => LoginPage(), // Rute ke LoginPage
        '/register': (context) => RegisterPage(), // Rute ke RegisterPage
        '/home': (context) => HomePage(), // Rute ke HomePage
        '/list-user': (context) => ListUser(), // Rute ke HomePage
        '/add-user': (context) => AddUser(), // Rute ke HomePage
      },
    );
  }
}
