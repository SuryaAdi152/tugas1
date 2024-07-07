import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/add_transaksi.dart';
import 'package:flutter_application_1/saldo_user.dart';
import 'package:get_storage/get_storage.dart';

class ListTransaksi extends StatefulWidget {
  const ListTransaksi({super.key});

  @override
  State<ListTransaksi> createState() => _ListTransaksiState();
}

class _ListTransaksiState extends State<ListTransaksi> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    getAnggota();
  }

  void getAnggota() async {
    try {
      final response = await dio.get(
        '$apiUrl/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
      );

      // print(response.data);
      setState(() {
        users = response.data['data']['anggotas'];
      });
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  void tambahTransaksi(Map<String, dynamic> user) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransaksi(user: user),
      ),
    );
  }

  void goSaldo(Map<String, dynamic> user) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SaldoUser(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Transaksi Anggota'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = users[index];
                  return Card(
                    child: ListTile(
                      title: Text(user['nama']),
                      subtitle: Text(user['tgl_lahir']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              tambahTransaksi(user);
                            },
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              goSaldo(user);
                            },
                            icon: const Icon(
                              Icons.money,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}