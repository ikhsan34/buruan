import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GroupDetail extends StatefulWidget {

  final String groupId;
  final String groupName;

  const GroupDetail({super.key, required this.groupId, required this.groupName});

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {

  final Future _prefs = SharedPreferences.getInstance();
  List group = [];

  void getGroupDetail() async {
    final SharedPreferences prefs = await _prefs;
    const api = 'http://ec2-13-250-57-227.ap-southeast-1.compute.amazonaws.com:5000';

    String token = 'Bearer ${prefs.getString('access_token')}';
    Map<String, String> header = {'Authorization': token};

    var response = await http.get(Uri.parse("$api/group/group/${widget.groupId}"), headers: header);
    var result = jsonDecode(response.body);

    setState(() {
      group = result['group'];
    });
  }

  void leaveGroup() async {
    final SharedPreferences prefs = await _prefs;
    Map user = jsonDecode(prefs.getString('user') ?? '{}');
    const api = 'http://ec2-13-250-57-227.ap-southeast-1.compute.amazonaws.com:5000';

    String token = 'Bearer ${prefs.getString('access_token')}';
    Map<String, String> header = {'Authorization': token};
    var response = await http.delete(Uri.parse("$api/group/${widget.groupId}/user/${user['id']}"), headers: header);
    if(response.statusCode == 200) {
      if(!mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGroupDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Detail'),
        backgroundColor: const Color(0xFF9ED5C5),
      ),
      backgroundColor: const Color(0xFFDEF5E5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Card(
              elevation: 10,
              child: ListTile(
                title: Text('Group Name: ${widget.groupName}'),
                subtitle: Text('Group ID: ${widget.groupId}'),
              ),
            )
          ),
          const Text('Members:'),
          Expanded(
            child: ListView.builder(
              itemCount: group.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(group[index]['name']),
                    subtitle: Text(group[index]['phone'] ?? '"User not inputed phone number yet"'),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
              heroTag: 'leave-group',
              onPressed: () {
                leaveGroup();
              },
              backgroundColor: Colors.redAccent,
              label: const Text('Leave Group'),
            ),
    );
  }
}