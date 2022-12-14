import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReminderDetail extends StatefulWidget {
  static String tag = 'ReminderDetail-page';

  final String id;
  final String title;
  final String desc;
  final String deadline;

  const ReminderDetail({required this.id, super.key, required this.title, required this.desc, required this.deadline});

  @override
  State<ReminderDetail> createState() => _ReminderDetailState();
}

class _ReminderDetailState extends State<ReminderDetail> {

  final Future _prefs = SharedPreferences.getInstance();
  bool isLoading = false;

  DateTime dateTime = DateTime.now();
  bool isGroup = false;
  List group = [];
  Object selectedGroup = '';
  late String id;


  // Update Reminder
  void updateReminder(String id, String name, String desc, String deadline) async {

    setState(() {
      isLoading = true;
    });

    // API
    const api = 'http://ec2-13-250-57-227.ap-southeast-1.compute.amazonaws.com:5000';
    final SharedPreferences prefs = await _prefs;

    String token = 'Bearer ${prefs.getString('access_token')}';
    Map<String, String> header = {'Authorization': token};

    Map data = {
      'name': name,
      'desc': desc,
      'deadline': deadline
    };


    var response = await http.put(Uri.parse("$api/reminder/$id"), body: data, headers: header);
    if (response.statusCode == 200) {
      // var jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      setState(() {
        isLoading = false;
        Navigator.of(context).pop();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }

  }

  void deleteReminder() async {
    setState(() {
      isLoading = true;
    });

    // API
    const api = 'http://ec2-13-250-57-227.ap-southeast-1.compute.amazonaws.com:5000';
    final SharedPreferences prefs = await _prefs;

    String token = 'Bearer ${prefs.getString('access_token')}';
    Map<String, String> header = {'Authorization': token};

    var response = await http.delete(Uri.parse("$api/reminder/$id"), headers: header);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        Navigator.of(context).pop();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<DateTime?> pickDate() => showDatePicker(
    context: context,
    initialDate: dateTime,
    firstDate: dateTime,
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
    //print(dateTime);
  }

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
    nameController.text = widget.title;
    descController.text = widget.desc;
    dateTime = DateTime.parse(widget.deadline);
  }

  @override
  Widget build(BuildContext context) {

    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    const spinkit = SpinKitFoldingCube(
      color: Color(0xff009688),
      size: 50.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Reminder"),
        backgroundColor: const Color(0xFF9ED5C5),
      ),
      backgroundColor: const Color(0xFFDEF5E5),
      body: isLoading ? spinkit : Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title form
                  const Text("Title"),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the title';
                      }
                      return null;
                    },
                    controller: nameController,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                    controller: descController,
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
                      padding: const EdgeInsets.symmetric(vertical: 15)
                    ),
                    onPressed: (() {
                      pickDateTime();
                    }),
                    child: Text('${dateTime.day}/${dateTime.month}/${dateTime.year} $hours:$minutes', style: const TextStyle(color: Color(0xFF009688)),),
                  ),
                  const SizedBox(height: 30),

                  // Submit button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF009688)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          updateReminder(id, nameController.text, descController.text, '${dateTime.year}/${dateTime.month}/${dateTime.day} $hours:$minutes:00');
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),

            // Delete button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () {
                  deleteReminder();
                },
                child: const Text('Delete'),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}