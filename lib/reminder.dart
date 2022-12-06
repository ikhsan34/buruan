import 'package:flutter/material.dart';

class Reminder extends StatefulWidget {
  static String tag = 'Reminder-page';

  const Reminder({super.key});
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {


  DateTime dateTime = DateTime.now();
  bool isGroup = false;

  Future<DateTime?> pickDate() => showDatePicker(
    context: context,
    initialDate: dateTime,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF009688)
          ),
        ),
        child: child!,
      );
    },
  );

  Future<TimeOfDay?> pickTime() => showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF009688)
          ),
        ),
        child: child!,
      );
    },
  );

  Future pickDateTime() async {

    DateTime? date = await pickDate();
    if(date == null) return;

    TimeOfDay? time = await pickTime();
    if(time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute
    );

    setState(() {
      this.dateTime = dateTime;
    });
    print(dateTime);
  }

  @override
  Widget build(BuildContext context) {

    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Reminder"),
        backgroundColor: const Color(0xFF9ED5C5),
      ),
      backgroundColor: const Color(0xFFDEF5E5),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[

            // Title form
            const Text("Title"),
            TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: const TextStyle(
                  color: Colors.grey
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10.0),

            // Description Form
            const Text("Description"),
            TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: const TextStyle(
                  color: Colors.grey
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10.0),

            // Deadline form
            const Text("Deadline"),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15)
              ),
              child: Text('${dateTime.day}/${dateTime.month}/${dateTime.year} $hours:$minutes', style: TextStyle(color: const Color(0xFF009688)),),
              onPressed: (() {
                pickDateTime();
              }),
            ),
            const SizedBox(height: 10.0),

            // Is for group
            Row(
              children: [
                Switch(value: isGroup, onChanged: ((value) {
                  setState(() {
                    isGroup = value;
                    print(isGroup);
                  });
                })),
                const Text('Insert reminder for group')
              ],
            ),
            const SizedBox(height: 10.0),
            if(isGroup) Row(
              children: [
                const Text('Group Code : '),
                const SizedBox(width: 20.0),
                Expanded(child: 
                TextFormField(
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
                ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Submit button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF009688)),
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
