// File: register_page.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'login_page.dart'; 

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _passwordVisible = false;

  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
               
                onSaved: (value) => _email = value!,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
               
                onChanged: (value) => _password = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
           
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Warna teks tombol
                  backgroundColor: Colors.deepPurple, // Warna background tombol
                ),
                onPressed: () {
                  goRegister(context, dio, apiUrl, nameController, emailController, passwordController);
                },
                child: Text('Register'),
              ),
              TextButton(
                onPressed: () {
                   Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  'Already have an account? Login here!',
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void goRegister(BuildContext context, dio, apiUrl, nameController,
    emailController, passwordController) async {
  try {
    final response = await dio.post(
      '$apiUrl/register',
      data: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    print(response.data);
    Navigator.pushReplacementNamed(context, '/login');
   
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}