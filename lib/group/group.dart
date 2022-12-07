import 'package:buruan/group/createGroup.dart';
import 'package:buruan/group/joinGroup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Group extends StatefulWidget {
  static String tag = 'Group-page';

  const Group({super.key});
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {

  final Future _prefs = SharedPreferences.getInstance();
  bool isLoading = true;
  List group = [];

  void getGroup() async {

    final SharedPreferences prefs = await _prefs;
    Map user = jsonDecode(prefs.getString('user') ?? '{}');
    const api = 'http://ec2-13-250-57-227.ap-southeast-1.compute.amazonaws.com:5000';

    String token = 'Bearer ${prefs.getString('access_token')}';
    Map<String, String> header = {'Authorization': token};

    var response = await http.get(Uri.parse("$api/group/user/${user['id']}"), headers: header);
    var result = jsonDecode(response.body)['group'];

    if(result != null) {
      for (var item in result) { 
        await http.get(Uri.parse("$api/group/${item['group_id']}"), headers: header).then((value)  {
          var response = jsonDecode(value.body);
          item['group_name'] = response['group']['name'];
        });
      }
    }
    
    if(mounted) {
      setState(() {
        group = result ?? [];
        isLoading = false;
      });
    }

  }

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getGroup();
  }
  
  @override
  Widget build(BuildContext context) {

    getGroup();

    const spinkit = SpinKitFoldingCube(
      color: Color(0xff009688),
      size: 50.0,
    );

    var gridView = ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      itemCount: group.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: ListTile(
            title: Text(group[index]['group_name']),
            subtitle: Text('Group Code: ${group[index]['group_id']}'),
          )
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Group"),
        backgroundColor: const Color(0xFF9ED5C5),
      ),
      backgroundColor: const Color(0xFFDEF5E5),
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton.extended(
              heroTag: 'create-group',
              backgroundColor: const Color(0xFF009688),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const CreateGroup())));
              },
              label: const Text('Create Group'),
            ),
          ), //button first

          Container(
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton.extended(
              heroTag: 'join-group',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const JoinGroup())));
              },
              backgroundColor: const Color(0xFF009688),
              label: const Text('Join Group'),
            ),
          ), // button second
        ],
      ),
      body: isLoading ? spinkit : group.isEmpty ? 
      const Center(
        child: Text('You dont have any group'),
      )
      : gridView
    );
  }
}
