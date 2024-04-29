import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {


  HomePage();

  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text('Welcome,', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {
                goUser(dio, myStorage, apiUrl);
              },
              child: Text('Cek User'),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login'); // Log out action
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}

void goUser(dio, myStorage, apiUrl) async {
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