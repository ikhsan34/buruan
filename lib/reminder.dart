import 'package:flutter/material.dart';

class Reminder extends StatefulWidget {
  static String tag = 'Reminder-page';

  const Reminder({super.key});
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    final title = TextFormField(
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

    final deadline = TextFormField(
        keyboardType: TextInputType.datetime,
        autofocus: false,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            suffixIcon: Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: Icon(
                Icons.calendar_month_outlined,
              ),
            )));

    final description = TextFormField(
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

    final ReminderButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF009688)),
        onPressed: () {},
        child: const Text('Submit'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Reminder"),
        backgroundColor: Color(0xFF9ED5C5),
      ),
      backgroundColor: const Color(0xFFDEF5E5),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Text("Title"),
            title,
            const SizedBox(height: 10.0),
            Text("Description"),
            description,
            const SizedBox(height: 10.0),
            Text("Deadline"),
            deadline,
            const SizedBox(height: 48),
            ReminderButton,
          ],
        ),
      ),
    );
  }
}
