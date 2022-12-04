import 'package:buruan/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:buruan/Register.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  static String tag = 'login-page';

  const Login({super.key});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final api =
      'http://ec2-13-250-57-227.ap-southeast-1.compute.amazonaws.com:5000';
  bool _isLoading = false;
  final Future _prefs = SharedPreferences.getInstance();

  login(String email, String password) async {
    setState(() {
      _isLoading = true;
    });
    final SharedPreferences prefs = await _prefs;
    Map data = {'email': email, 'password': password};
    var jsonResponse;
    var response = await http.post(Uri.parse('$api/login'), body: data); // API
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        prefs.setString("access_token", jsonResponse['access_token']);
        prefs.setString('user_id', jsonResponse['user']['id']);
        prefs.setString('user', jsonEncode(jsonResponse['user']));
        if (!mounted) return;
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

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const logo = Center(
      child: Text("Buruan!"),
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

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF009688)),
        onPressed: (() {
          setState(() {
            _isLoading = true;
          });
          login(emailController.text, passwordController.text);
        }),
        child: const Text('Login'),
      ),
    );

    final registerButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF009688)),
        onPressed: () {
          Navigator.of(context).pushNamed(Register.tag);
        },
        child: const Text('Register'),
      ),
    );

    final forgotLabel = TextButton(
      child: const Text(
        'Forgot password?',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );

    final spinkit = SpinKitFoldingCube(
      color: Color(0xff009688),
      size: 50.0,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF9ED5C5),
      body: _isLoading ? spinkit : Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: 48.0),
            email,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 24.0),
            loginButton,
            registerButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
