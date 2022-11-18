import 'dart:convert';

import 'package:buruan/AddReminder.dart';
import 'package:buruan/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Future _prefs = SharedPreferences.getInstance();
  //late Future<ReminderModel> dataReminder;
  List _reminder = [];

  Future<List> _getReminder() async {
    final SharedPreferences prefs = await _prefs;
    String token = 'Bearer ${prefs.getString('access_token')}';
    Map<String, String> header = {'Authorization': token};

    final response = await http
        .get(Uri.parse("http://192.168.88.254:8080/reminder"), headers: header);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      setState(() {
        _reminder = data['reminder'];
      });
      return data['reminder'];
    } else {
      throw Exception('Failed to load reminder');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn();
    _getReminder();
  }

  isLoggedIn() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getString("access_token") == null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: ((context) => const Login())),
          (route) => false);
    }
  }

  logout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9ED5C5),
        foregroundColor: Colors.white,
        title: const Text("Dashboard"),
      ),
      body: ListView.builder(
        itemCount: _reminder.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_reminder[index]['name']),
              subtitle: Text(_reminder[index]['desc']),
            ),
          );
        },
      ),
      // body: SingleChildScrollView(
      //   child: Column(children: [
      //     for (var i = 0; i <= 10; i++) ...[
      //       Card(
      //         margin: EdgeInsets.all(10),
      //         child: ListTile(
      //           title: const Text('Pengembangan Perangkat Lunak'),
      //           subtitle: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Text(
      //                   'Tugas besar membuat aplikasi terdistribusi menggunakan API'),
      //               const Padding(padding: EdgeInsets.all(5)),
      //               Row(
      //                 children: const [
      //                   Text('Subtitle 2'),
      //                   Spacer(),
      //                   Text('Kanan')
      //                 ],
      //               ),
      //             ],
      //           ),
      //           // trailing: Text('Trailing'),
      //           isThreeLine: true,
      //         ),
      //       ),
      //     ]
      //   ]),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF009688),
        onPressed: (() {
          Navigator.of(context).pushNamed(AddReminder.tag);
        }),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Nama Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF9ED5C5),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListTile(
                    title: Text('User Profile'),
                  ),
                  ListTile(
                    title: Text('Group'),
                  ),
                  ListTile(
                    title: Text('History'),
                  ),
                  ListTile(
                    title: Text('Logout'),
                    onTap: (() => logout()),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
