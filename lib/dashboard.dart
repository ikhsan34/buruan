import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new Dashboard()));
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
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF009688),
        title: new Text("Buruan"),
        leading: new Icon(Icons.menu),
        /* actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.access_time),
              onPressed: () {
                txt = 'this is arrow button';
              }),
          new IconButton(
              icon: new Icon(Icons.data_usage),
              onPressed: () {
                txt = 'this is arrow button';
              })
        ], */
      ),
      body: new Center(
        child: new Text(txt),
      ),
    );
  }
}
