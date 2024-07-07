import 'package:flutter/material.dart';
import 'package:flutter_application_1/list_transaksi.dart';
import 'package:get_storage/get_storage.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'add_user.dart';
import 'list_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets binding is initialized
  await GetStorage.init(); // Initialize GetStorage
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(), // Rute ke LoginPage
        '/register': (context) => RegisterPage(), // Rute ke RegisterPage
        '/home': (context) => HomePage(), // Rute ke HomePage
        '/list-user': (context) => ListUser(), // Rute ke ListUser
        '/add-user': (context) => AddUser(), // Rute ke AddUser
        '/list-transaksi': (context) => ListTransaksi(), // Rute ke AddUser
      },
    );
  }
}
