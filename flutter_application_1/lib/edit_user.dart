import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/list_user.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:page_transition/page_transition.dart';

class EditUser extends StatefulWidget {
  final Map<String, dynamic> user;
  
  const EditUser({
    super.key,
    required this.user,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  late TextEditingController noIndukController;
  late TextEditingController namaController;
  late TextEditingController alamatController;
  late TextEditingController tglLahirController;
  late TextEditingController teleponController;

  @override
  void initState() {
    super.initState();
    noIndukController =
        TextEditingController(text: widget.user['nomor_induk'].toString());
    namaController = TextEditingController(text: widget.user['nama']);
    alamatController = TextEditingController(text: widget.user['alamat']);
    tglLahirController = TextEditingController(text: widget.user['tgl_lahir']);
    teleponController = TextEditingController(text: widget.user['telepon']);
  }

  void updateUser() async {
    try {
      final response = await dio.put(
        '$apiUrl/anggota/${widget.user['id']}',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
        data: {
          'nomor_induk': noIndukController.text,
          'nama': namaController.text,
          'alamat': alamatController.text,
          'tgl_lahir': tglLahirController.text,
          'telepon': teleponController.text,
        },
      );

      print(response.data);

      // Pindah halaman ke home jika berhasil register
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListUser(),
        ),
      );
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Edit Data Anggota',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: noIndukController,
              decoration: InputDecoration(
                  labelText: 'Nomor Induk',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), width: 2),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), width: 2),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: alamatController,
              decoration: InputDecoration(
                  labelText: 'Alamat',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), width: 2),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: tglLahirController,
              decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), width: 2),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: teleponController,
              decoration: InputDecoration(
                  labelText: 'Telephone',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), width: 2),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  updateUser();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 14, 95, 161),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                ),
                child: const Text('Simpan',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)))),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}