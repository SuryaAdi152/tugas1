import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Tambahkan Data Anggota',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
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
                    Navigator.pushReplacementNamed(context, '/list-user'); // Log out action
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