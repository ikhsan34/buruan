import 'package:flutter/material.dart';
import 'package:buruan/group.dart';

class GroupDetail extends StatefulWidget {
  static String tag = 'GroupDetail-page';

  const GroupDetail({super.key});
  @override
  _GroupDetailState createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  @override
  Widget build(BuildContext context) {
    final groupName = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );

    final memberCount = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );

    final LeaveButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF4848)),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: const Text('Are you sure want to Leave?'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    backgroundColor: Colors.white),
                onPressed: () => Navigator.pop(context, 'cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF009688)),
                onPressed: () => {
                  // Navigator.of(context).pushNamed(Group.tag)
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        ),
        child: const Text('Leave Group'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Group Detail"),
        backgroundColor: Color(0xFF9ED5C5),
      ),
      backgroundColor: const Color(0xFFDEF5E5),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Text("Group Name"),
            groupName,
            const SizedBox(height: 10.0),
            Text("Member Count"),
            memberCount,
            const SizedBox(height: 48),
            LeaveButton,
          ],
        ),
      ),
    );
  }
}
