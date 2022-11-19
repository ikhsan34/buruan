import 'package:flutter/material.dart';
import 'package:buruan/login.dart';
import 'package:buruan/profile.dart';
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
          // Navigator.of(context).pushNamed(Group.tag);
        },
        child: const Text('Group'),
      ),
    );

    final historyButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8EC3B0)),
        onPressed: () {
          // Navigator.of(context).pushNamed(History.tag);
        },
        child: const Text('History'),
      ),
    );

    final logOutButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8EC3B0)),
        onPressed: () {
          Navigator.of(context).pushNamed(Login.tag);
        },
        child: const Text('Log Out'),
      ),
    );

    final reminderCard = Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                // leading: Icon(Icons.album),
                title: Text('Name'),
                subtitle: Text('Description'),
              ),
              const SizedBox(width: 300, height: 30),
              InkWell(splashColor: Colors.blue.withAlpha(30), onTap: () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'group name',
                    style: TextStyle(
                      color: Color(0xFF000000).withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'date',
                    style: TextStyle(
                      color: Color(0xFF000000).withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ));

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
      body: Center(
          child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        children: [reminderCard],
      )),
      drawer: Drawer(
        backgroundColor: Color(0xFF9ED5C5),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 24.0, right: 24.0, left: 24.0),
          children: <Widget>[
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
