import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SaldoUser extends StatefulWidget {
  final Map<String, dynamic> user;

  const SaldoUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<SaldoUser> createState() => _SaldoUserState();
}

class _SaldoUserState extends State<SaldoUser> {
  final Dio dio = Dio();
  final GetStorage myStorage = GetStorage();
  final String apiUrl = 'https://mobileapis.manpits.xyz/api';

  late String nama;
  late String alamat;
  late String telepon;
  late String tglLahir;
  String saldo = '0';
  List<Map<String, dynamic>> transaksiHistory = [];

  @override
  void initState() {
    super.initState();
    nama = widget.user['nama'];
    alamat = widget.user['alamat'];
    telepon = widget.user['telepon'];
    tglLahir = widget.user['tgl_lahir'];

    getSaldo();
    getTransaksiHistory();
  }

  void getSaldo() async {
    try {
      final response = await dio.get(
        '$apiUrl/saldo/${widget.user['id']}',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
      );

      print(response.data);

      setState(() {
        saldo = response.data['data']['saldo'].toString();
      });
    } on DioError catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  void getTransaksiHistory() async {
    try {
      final response = await dio.get(
        '$apiUrl/tabungan/${widget.user['id']}',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
      );

      print(response);

      setState(() {
        transaksiHistory = List<Map<String, dynamic>>.from(
            response.data['data']['tabungan']);
      });
    } on DioError catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  Color getTextColor(int trxId) {
    if (trxId == 3 || trxId == 6) {
      return Colors.white; // Warna putih untuk penarikan
    } else if (trxId == 2 || trxId == 5) {
      return Colors.white; // Warna putih untuk tambah saldo
    } else {
      return Colors.black; // Warna hitam untuk transaksi lainnya
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saldo User'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nama,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    telepon,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    alamat,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    tglLahir,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Sisa saldo : $saldo',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Histori Transaksi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: transaksiHistory.map((transaksi) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: transaksi['trx_id'] == 3 || transaksi['trx_id'] == 6
                        ? const Color.fromARGB(255, 194, 21, 8).withOpacity(0.8) // Warna untuk penarikan
                        : transaksi['trx_id'] == 2 || transaksi['trx_id'] == 5
                            ? const Color.fromARGB(255, 4, 188, 10).withOpacity(0.8) // Warna untuk tambah saldo
                            : Colors.grey.withOpacity(0.8), // Warna default untuk transaksi lainnya
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaksi['trx_tanggal'],
                        style: TextStyle(
                          fontSize: 20,
                          color: getTextColor(transaksi['trx_id']),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        getTransaksiDescription(transaksi['trx_id']),
                        style: TextStyle(
                          fontSize: 20,
                          color: getTextColor(transaksi['trx_id']),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        getNominalWithSign(transaksi['trx_id'], transaksi['trx_nominal']),
                        style: TextStyle(
                          fontSize: 20,
                          color: getTextColor(transaksi['trx_id']),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String getTransaksiDescription(int trxId) {
    switch (trxId) {
      case 1:
        return 'Setoran Awal';
      case 2:
        return 'Tambah Saldo';
      case 3:
        return 'Penarikan';
      case 5:
        return 'Koreksi Penambahan';
      case 6:
        return 'Koreksi Penarikan';
      default:
        return 'Transaksi';
    }
  }

  String getNominalWithSign(int trxId, int nominal) {
    String sign = '';
    switch (trxId) {
      case 1:
      case 2:
      case 5:
        sign = '+';
        break;
      case 3:
      case 6:
        sign = '-';
        break;
      default:
        sign = '';
    }

    return '$sign Rp. $nominal';
  }
}
