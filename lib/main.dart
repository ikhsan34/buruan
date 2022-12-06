// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'dart:js';

import 'package:buruan/history.dart';
import 'package:buruan/login.dart';
import 'package:buruan/profile.dart';
import 'package:flutter/material.dart';
import 'package:buruan/register.dart';
import 'package:buruan/dashboard.dart';
import 'package:buruan/reminder.dart';
import 'package:buruan/reminderDetail.dart';
import 'package:buruan/group/group.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routes = <String, WidgetBuilder>{
    Login.tag: (context) => const Login(),
    Register.tag: (context) => const Register(),
    Dashboard.tag: (context) => const Dashboard(),
    Reminder.tag: (context) => const Reminder(),
    Profile.tag: (context) => const Profile(),
    ReminderDetail.tag: (context) => const ReminderDetail(),
    Group.tag: (context) => const Group(),
    History.tag: (context) => const History(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buruan',
      home: const Dashboard(),
      routes: routes,
    );
  }
}
