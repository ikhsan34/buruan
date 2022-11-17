import 'package:flutter/material.dart';
import 'package:buruan/login.dart';
import 'package:buruan/reminder.dart';

void main() {
  runApp(new MaterialApp(home: Dashboard()));
}

class Dashboard extends StatefulWidget {
  static String tag = 'dashboard-page';

  const Dashboard({super.key});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String txt = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BURUAN"),
        backgroundColor: Color(0xFF9ED5C5),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_sharp),
        backgroundColor: Color(0xff009688),
        foregroundColor: Color(0xffffffff),
        onPressed: () => {Navigator.of(context).pushNamed(Reminder.tag)},
      ),
      body: const Center(
        child: Text('Dashboard'),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFF9ED5C5),
        child: Column(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 50.0,
              margin: EdgeInsets.all(2),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFFFFFFFF),
                backgroundColor: Color(0xFF8EC3B0),
              ),
              onPressed: () {},
              child: const Text('Profile'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFFFFFFFF),
                backgroundColor: Color(0xFF8EC3B0),
              ),
              onPressed: () {},
              child: const Text('Group'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFFFFFFFF),
                backgroundColor: Color(0xFF8EC3B0),
              ),
              onPressed: () {},
              child: const Text('History'),
            ),
            Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.bottomCenter,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFFFFFFFF),
                backgroundColor: Color(0xFF8EC3B0),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Login.tag);
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
