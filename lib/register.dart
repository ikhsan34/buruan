import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:login/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Dashboard.dart';

class Register extends StatefulWidget {
  static String tag = 'login-page';

  const Register({super.key});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final Future _prefs = SharedPreferences.getInstance();

  register(String name, String phone, String email, String password) async {
    final SharedPreferences prefs = await _prefs;
    Map data = {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    };
    var jsonResponse;
    var response = await http.post(
        Uri.parse("http://192.168.232.56:8080/register"),
        body: data); // localhost:8080
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        prefs.setString("access_token", jsonResponse['access_token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => Dashboard(),
            ),
            (route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const logo = Center(
      child: Text("Buruan"),
    );

    final name = TextFormField(
      controller: nameController,
      keyboardType: TextInputType.name,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'name',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );

    final phone = TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'phone',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );

    final email = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Email',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );

    final password = TextFormField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
    final confirmationPassword = TextFormField(
      controller: confirmPasswordControler,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );

    final registerButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF009688)),
        onPressed: () {
          //Navigator.of(context).pushNamed(HomePage.tag);
          setState(() {
            _isLoading = true;
          });
          register(nameController.text, phoneController.text,
              emailController.text, passwordController.text);
        },
        child: const Text('Register'),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF9ED5C5),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: 48.0),
            name,
            const SizedBox(height: 8.0),
            phone,
            const SizedBox(height: 8.0),
            email,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 8.0),
            confirmationPassword,
            const SizedBox(height: 48),
            registerButton,
          ],
        ),
      ),
    );
  }
}
