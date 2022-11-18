import 'dart:convert';
import 'dart:ffi';

import 'package:buruan/Dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});
  static String tag = 'AddReminder';

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  bool _isLoading = false;

  final Future _prefs = SharedPreferences.getInstance();

  addReminder(String name, String desc, String deadline) async {
    final SharedPreferences prefs = await _prefs;

    String token = 'Bearer ${prefs.getString('access_token')}';

    Map<String, String> header = {'Authorization': token};
    Map data = {
      'user_id': prefs.getString('user_id').toString(),
      'name': name,
      'desc': desc,
      'deadline': deadline
    };

    var jsonResponse;
    var response = await http.post(
        Uri.parse("http://192.168.88.254:8080/reminder"),
        body: data,
        headers: header); // localhost:8080
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
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
  final descController = TextEditingController();
  final deadlineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final name = TextFormField(
      controller: nameController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Reminder Name',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );

    final desc = TextFormField(
      controller: descController,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Description',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
    final deadline = TextFormField(
      controller: deadlineController,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Deadline',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );

    final submitButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF009688)),
        onPressed: () {
          //Navigator.of(context).pushNamed(HomePage.tag);
          setState(() {
            _isLoading = true;
          });
          addReminder(nameController.text, descController.text,
              deadlineController.text);
        },
        child: const Text('Submit'),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9ED5C5),
        foregroundColor: Colors.white,
        title: const Text('Add Reminder'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Center(
              child: Text(
                'Add Reminder',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 48.0),
            name,
            const SizedBox(height: 8.0),
            desc,
            const SizedBox(height: 8.0),
            deadline,
            const SizedBox(height: 48),
            submitButton,
          ],
        ),
      ),
    );
  }
}
