import 'package:buruan/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Future _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn();
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
        backgroundColor: Color(0xFF9ED5C5),
        foregroundColor: Colors.white,
        title: const Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for(var i = 0; i <= 10; i++)...[
              Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text('Pengembangan Perangkat Lunak'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tugas besar membuat aplikasi terdistribusi menggunakan API'),
                    Padding(padding: EdgeInsets.all(5)),
                    Row(
                      children: [
                        Text('Subtitle 2'),
                        Spacer(),
                        Text('Kanan')
                      ],
                    ),
                  ],
                ),
                // trailing: Text('Trailing'),
                isThreeLine: true,
              ),
            ),
            ]
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF009688),
        onPressed: (() {
          
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
                child: Text('Nama Profile', style: TextStyle(color: Colors.white),),
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
