import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final Future _prefs = SharedPreferences.getInstance();

Future<List> getReminder(String api) async {
  final SharedPreferences prefs = await _prefs;
  Map user = jsonDecode(prefs.getString('user') ?? '{}');

  List reminder = [];

  String token = 'Bearer ${prefs.getString('access_token')}';
  Map<String, String> header = {'Authorization': token};

  // Get reminder by user id
  var response = await http.get(Uri.parse("$api/reminder/user/${user['id']}"), headers: header);
  var reminderByUser = jsonDecode(response.body);

  // Get user membership
  response = await http.get(Uri.parse("$api/group/user/${user['id']}"), headers: header);
  var listUserGroup = jsonDecode(response.body);

  // Get reminder by group id
  List reminderGroup = [];
  for (var item in listUserGroup['group']) {
    // Get reminders
    response = await http.get(Uri.parse("$api/reminder/group/${item['group_id']}"), headers: header);
    var reminderByGroup = jsonDecode(response.body);

    // Set reminder to variable
    reminderGroup.add(reminderByGroup['reminder']);
  }

  reminder = reminderByUser['reminder'] ?? [];

  print(reminderGroup);

  if(reminderGroup.isNotEmpty && reminderGroup[0] != null) {
    for (var item in reminderGroup[0]) { // Must set index to 0 because result is list
      await http.get(Uri.parse("$api/group/${item['group_id']}"), headers: header).then((value)  {
        var response = jsonDecode(value.body);
        item['group_name'] = response['group']['name'];
        reminder.add(item);
      });
    }
  }

  return reminder;
}