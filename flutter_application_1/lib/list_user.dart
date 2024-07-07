import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/edit_user.dart';
import 'package:get_storage/get_storage.dart';

class ListUser extends StatefulWidget {
  ListUser({super.key});

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    try {
      final response = await dio.get(
        '$apiUrl/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
      );

      setState(() {
        users = response.data['data']['anggotas'];
      });
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  //

  void deleteUser(int id) async {
    try {
      final response = await dio.delete(
        '$apiUrl/anggota/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
      );

      print(response.data);
      getUser();
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }
  

  // Fungsi baru untuk menampilkan dialog dengan detail pengguna
  void showUserDetails(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: ${user['nama']}'),
              Text('Tanggal Lahir: ${user['tgl_lahir']}'),
              Text('Alamat: ${user['alamat']}'),
              // Tambahkan detail lainnya sesuai kebutuhan
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditUser(user: user)),
                );
              },
              child: Text('Edit'),
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
        title: const Text('List User'),
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
                      leading: Icon(Icons.person),        
                      title: Text(user['nama']),
                      subtitle: Text ('Nomor Induk: ${user['nomor_induk'].toString()}'),
                      onTap: () {
                        showUserDetails(user); // Menampilkan dialog saat item diklik
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=> EditUser(user: user)),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteUser(user['id']);
                            },
                            icon: Icon(
                              Icons.delete,
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
