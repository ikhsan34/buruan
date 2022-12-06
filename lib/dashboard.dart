import 'package:flutter/material.dart';
import 'package:buruan/login.dart';
import 'package:buruan/profile.dart';
import 'package:buruan/reminder.dart';
import 'package:buruan/reminderDetail.dart';
import 'package:buruan/group/group.dart';
import 'package:buruan/history.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Data
import 'package:buruan/model/Data.dart';

class Dashboard extends StatefulWidget {
  static String tag = 'dashboard-page';

  const Dashboard({super.key});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // API
  final api = 'http://ec2-13-250-57-227.ap-southeast-1.compute.amazonaws.com:5000';
  final Future _prefs = SharedPreferences.getInstance();

  // User Data
  Map user = {};
  List reminder = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn();
  }

  isLoggedIn() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getString("access_token") == null) {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: ((context) => const Login())),
          (route) => false);
    } else {
      getReminder(api).then((value) {
        //print(value);
        setState(() {
          reminder = value;
          isLoading = false;
        });
      });
      setState(() {
        user = jsonDecode(prefs.getString('user') ?? '{}');
      });
      //_getReminder();
    }
  }

  logout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    isLoggedIn();
    //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {

    final profileButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8EC3B0)),
        onPressed: () {
          Navigator.of(context).pushNamed(Profile.tag);
        },
        child: const Text('Profile'),
      ),
    );

    final groupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8EC3B0)),
        onPressed: () {
          Navigator.of(context).pushNamed(Group.tag);
        },
        child: const Text('Group'),
      ),
    );

    final historyButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8EC3B0)),
        onPressed: () {
          Navigator.of(context).pushNamed(History.tag);
        },
        child: const Text('History'),
      ),
    );

    final logOutButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8EC3B0)),
        onPressed: () {
          logout();
        },
        child: const Text('Log Out'),
      ),
    );

    final reminderCard = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Card(
        color: Color(0xFFDEF5E5),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.of(context).pushNamed(ReminderDetail.tag);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                // leading: Icon(Icons.album),
                title: Text('Name'),
                subtitle: Text('Description'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    child: const Text('Group Name'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('Date'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    const spinkit = SpinKitFoldingCube(
      color: Color(0xff009688),
      size: 50.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("BURUAN"),
        backgroundColor: Color(0xFF9ED5C5),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'dashboard',
        child: Icon(Icons.add_sharp),
        backgroundColor: Color(0xff009688),
        foregroundColor: Color(0xffffffff),
        onPressed: () => Navigator.of(context).pushNamed(Reminder.tag),
      ),
      body: isLoading
          ? spinkit
          : ListView.builder(
              itemCount: reminder.length,
              itemBuilder: ((context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: const Color(0xFFDEF5E5),
                  child: ListTile(
                    isThreeLine: true,
                    title: Text(reminder[index]['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(reminder[index]['desc']),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text(reminder[index]['group_name'] ?? 'Personal'),
                            Spacer(),
                            Text(reminder[index]['deadline'])
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })),
      drawer: Drawer(
        backgroundColor: const Color(0xFF9ED5C5),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 24.0, right: 24.0, left: 24.0),
          children: <Widget>[
            DrawerHeader(
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomLeft,
                child: Text(
                  user['name'] ?? '',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            profileButton,
            const SizedBox(height: 8.0),
            groupButton,
            const SizedBox(height: 8.0),
            historyButton,
            const SizedBox(height: 48),
            logOutButton,
          ],
        ),
        /*        child: Column(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.all(8),
          children:[
           Container(
              height: 50.0,
              margin: EdgeInsets.all(2),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFFFFFFFF),
                backgroundColor: Color(0xFF8EC3B0),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Profile.tag);
              },
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
        ),*/
      ),
    );
  }
}
