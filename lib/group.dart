import 'package:flutter/material.dart';

class Group extends StatefulWidget {
  static String tag = 'Group-page';

  const Group({super.key});
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  @override
  Widget build(BuildContext context) {
    final GroupCard = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            // Navigator.of(context).pushNamed(ReminderDetail.tag);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                // leading: Icon(Icons.album),
                title: Text('Group Name'),
                subtitle: Text('Member: 12'),
              )
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Group"),
        backgroundColor: Color(0xFF9ED5C5),
      ),
      backgroundColor: const Color(0xFFDEF5E5),
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: FloatingActionButton.extended(
              heroTag: 'create-group',
              backgroundColor: Color(0xFF009688),
              onPressed: () {},
              label: const Text('Create Group'),
            ),
          ), //button first

          Container(
            margin: EdgeInsets.all(10),
            child: FloatingActionButton.extended(
              heroTag: 'join-group',
              onPressed: () {},
              backgroundColor: Color(0xFF009688),
              label: const Text('Join Group'),
            ),
          ), // button second
        ],
      ),
      body: GroupCard,
    );
  }
}
