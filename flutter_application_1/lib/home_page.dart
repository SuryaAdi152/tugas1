import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'list_user.dart';
import 'add_user.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color.fromARGB(255, 126, 208, 231),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0), // Mengurangi padding agar kotak lebih kecil
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            children: <Widget>[
              buildButton(context, Icons.person_search, 'Cek User', () {
                goUser(dio, myStorage, apiUrl);
              }),
              buildButton(context, Icons.list, 'Lihat List User', () {
                Navigator.pushNamed(context, '/list-user');
              }),
              buildButton(context, Icons.swap_horiz, 'Transaksi User', () {
                Navigator.pushNamed(context, '/list-transaksi');
              }),
              buildButton(context, Icons.person_add, 'Tambahkan User', () {
                Navigator.pushNamed(context, '/add-user');
              }),
              buildButton(context, Icons.logout, 'Log Out', () {
                Navigator.pushReplacementNamed(context, '/login');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, IconData icon, String label, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(10), // Sedikit melengkungkan sudut
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(2.0), // Mengurangi padding agar konten lebih kompak
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 30, color: Colors.white), // Mengurangi ukuran ikon
              SizedBox(height: 5),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12), // Mengurangi ukuran teks
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void goUser(Dio dio, GetStorage myStorage, String apiUrl) async {
  try {
    final response = await dio.get(
      '$apiUrl/user',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );
    print(response.data);
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}

// void logout(BuildContext context, GetStorage myStorage) { // <-- Perubahan di sini
//   myStorage.remove('token'); // <-- Perubahan di sini
//   Navigator.pushReplacementNamed(context, '/login'); // <-- Perubahan di sini
// }