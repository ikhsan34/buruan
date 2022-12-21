import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  static String tag = 'History-page';

  final String id;

  const History({super.key, required this.id});
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  // API
  final api = 'http://ec2-13-250-57-227.ap-southeast-1.compute.amazonaws.com:5000';
  final Future _prefs = SharedPreferences.getInstance();

  bool isLoading = true;
  List reminder = [];

  void getReminder() async {

    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await _prefs;

    String token = 'Bearer ${prefs.getString('access_token')}';
    Map<String, String> header = {'Authorization': token};

    var response = await http.get(Uri.parse("$api/history/${widget.id}"), headers: header);

    if(response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        reminder = result['history'];
        isLoading = false;
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
    getReminder();
  }
  
  @override
  Widget build(BuildContext context) {

    const spinkit = SpinKitFoldingCube(
      color: Color(0xff009688),
      size: 50.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        backgroundColor: Color(0xFF9ED5C5),
      ),
      backgroundColor: const Color(0xFFDEF5E5),
      body: isLoading
          ? spinkit
          : reminder.isEmpty ? const Center(child: Text("You dont have any history, let's create one."),)
          : ListView.builder(
              itemCount: reminder.length,
              itemBuilder: ((context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.white,
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
                            Text(reminder[index]['deadline'])
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
