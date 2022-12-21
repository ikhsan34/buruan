import 'package:flutter/material.dart';
import 'package:buruan/login.dart';
import 'package:buruan/profile.dart';
import 'package:buruan/reminder.dart';
import 'package:buruan/reminderDetail.dart';
import 'package:buruan/group/group.dart';
import 'package:buruan/history.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8EC3B0)),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(Profile.tag).then((_) => isLoggedIn());
        },
        child: const Text('Profile'),
      ),
    );

    final groupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8EC3B0)),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(Group.tag).then((_){
            getReminder(api).then((value){
              setState(() {
                reminder = value;
                isLoading = false;
              });
            });
          });
        },
        child: const Text('Group'),
      ),
    );

    final historyButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8EC3B0)),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return History(id: user['id']);
          })));
        },
        child: const Text('History'),
      ),
    );

    final logOutButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8EC3B0)),
        onPressed: () {
          logout();
        },
        child: const Text('Log Out'),
      ),
    );


    const spinkit = SpinKitFoldingCube(
      color: Color(0xff009688),
      size: 50.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: const Color(0xFF9ED5C5),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'dashboard',
        backgroundColor: const Color(0xff009688),
        foregroundColor: const Color(0xffffffff),
        onPressed: () => Navigator.of(context).pushNamed(Reminder.tag).then((_) {
          getReminder(api).then((value) {
            //print(value);
            setState(() {
              reminder = value;
              isLoading = false;
            });
          });
        }),
        child: const Icon(Icons.add_sharp),
      ),
      body: isLoading
          ? spinkit
          : reminder.isEmpty ? const Center(child: Text("You dont have any reminder, let's create one."),)
          : ListView.builder(
              itemCount: reminder.length,
              itemBuilder: ((context, index) {

                DateTime dateTime = DateTime.parse(reminder[index]['deadline']);
                final hours = dateTime.hour.toString().padLeft(2, '0');
                final minutes = dateTime.minute.toString().padLeft(2, '0');

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            const Spacer(),
                            //Text(reminder[index]['deadline'])
                            Text('${dateTime.day}/${dateTime.month}/${dateTime.year} $hours:$minutes')
                          ],
                        )
                      ],
                    ),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) {
                      return ReminderDetail(id: reminder[index]['id'], title: reminder[index]['name'], desc: reminder[index]['desc'], deadline: reminder[index]['deadline']);
                    }))).then((_) {
                      getReminder(api).then((value) {
                      //print(value);
                      setState(() {
                        reminder = value;
                        isLoading = false;
                      });
                    });
                    }),
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
                padding: const EdgeInsets.all(10),
                alignment: Alignment.bottomLeft,
                child: Text(
                  user['name'] ?? '',
                  style: const TextStyle(color: Colors.white),
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
      ),
    );
  }
}
