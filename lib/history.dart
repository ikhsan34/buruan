import 'package:flutter/material.dart';

class History extends StatefulWidget {
  static String tag = 'History-page';

  const History({super.key});
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final HistoryCard = Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Card(
          // color: Color(0xFFDEF5E5),
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
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: Color(0xFF9ED5C5),
      ),
      backgroundColor: const Color(0xFFDEF5E5),
      body: Center(
        child: HistoryCard,
      ),
    );
  }
}
