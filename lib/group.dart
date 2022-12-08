import 'package:flutter/material.dart';
import 'package:buruan/groupDetail.dart';

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
      child: SizedBox(
        width: 180,
        height: 80,
        child: Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.of(context).pushNamed(GroupDetail.tag);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                ListTile(
                  // leading: Icon(Icons.album),
                  title: Text('Group Name'),
                  subtitle: Text('Member: 12'),
                )
              ],
            ),
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
              heroTag: "btn 1",
              backgroundColor: Color(0xFF009688),
              onPressed: () {},
              label: const Text('Create Group'),
            ),
          ), //button first

// Join Group Button
          Container(
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton.extended(
              heroTag: "btn 2",
              onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text("Group Code"),
                        content: TextFormField(
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF009688))),
                            )),
                        actions: <Widget>[
                          Center(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                                backgroundColor: const Color(0xFF009688)),
                            child: const Text("Join"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ))
                        ],
                      )),
              backgroundColor: const Color(0xFF009688),
              label: const Text('Join Group'),
            ),
          ), // button second
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GroupCard,
            GroupCard,
          ],
        ),
      ),
    );
  }
}
