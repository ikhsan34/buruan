import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  final api = 'http://ec2-13-250-57-227.ap-southeast-1.compute.amazonaws.com:5000';
  bool isLoading = false;
  final Future _prefs = SharedPreferences.getInstance();

  createGroup(String name) async {

    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await _prefs;
    Map user = jsonDecode(prefs.getString('user') ?? '{}');

    String token = 'Bearer ${prefs.getString('access_token')}';
    Map<String, String> header = {'Authorization': token};

    Map data = {
      'user_id': user['id'],
      'name': name
    };

    var response = await http.post(Uri.parse('$api/group'), body: data, headers: header);
    
    if(response.statusCode == 200) {
      // var result = jsonDecode(response.body);
      // print(result);
      setState(() {
        isLoading = false;
        Navigator.of(context).pop();
      });
    }
    //print(response.statusCode);

  }

  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    const spinkit = SpinKitFoldingCube(
      color: Color(0xff009688),
      size: 50.0,
    );
    
    return Scaffold(
      backgroundColor: const Color(0xFFDEF5E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF9ED5C5),
        title: const Text('Create Group'),
      ),
      body: isLoading ? spinkit : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a group name';
                      }
                      return null;
                    },
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    autofocus: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Group Name',
                      contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF009688)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        createGroup(nameController.text);
                      }
                    },
                    child: const Text('Create'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}