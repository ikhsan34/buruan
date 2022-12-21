import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  static String tag = 'Profile-page';

  const Profile({super.key});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final Future _prefs = SharedPreferences.getInstance();
  Map user = {};
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  bool isLoading = false;

  void getUserData () async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      user = jsonDecode(prefs.getString('user') ?? '{}');
      nameController.text = user['name'];
      phoneController.text = user['phone'] ?? '';
      emailController.text = user['email'];
    });
    //print(user);
  }

  void updateProfile(String name, String phone) async {

    setState(() {
      isLoading = true;
    });

    // API
    const api = 'http://ec2-13-250-57-227.ap-southeast-1.compute.amazonaws.com:5000';
    final SharedPreferences prefs = await _prefs;

    String token = 'Bearer ${prefs.getString('access_token')}';
    Map<String, String> header = {'Authorization': token};

    Map data = {
      'name': name,
      'phone': phone,
    };

    var response = await http.put(Uri.parse("$api/profile/${user['id']}"), body: data, headers: header);

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await _prefs;
      prefs.clear();

      setState(() {
        isLoading = false;
        Navigator.of(context).pop();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  

  @override
  Widget build(BuildContext context) {

    const spinkit = SpinKitFoldingCube(
      color: Color(0xff009688),
      size: 50.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: const Color(0xFF9ED5C5),
      ),
      backgroundColor: const Color(0xFFDEF5E5),
      body: isLoading ? spinkit : Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              autofocus: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Nama',
                contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              autofocus: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Nomor Telepon',
                contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              enabled: false,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white30,
                hintText: 'Email',
                contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF009688)),
                onPressed: () {
                  updateProfile(nameController.text, phoneController.text);
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
