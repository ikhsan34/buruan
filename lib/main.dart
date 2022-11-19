// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:buruan/login.dart';
import 'package:buruan/profile.dart';
import 'package:flutter/material.dart';
import 'package:buruan/register.dart';
import 'package:buruan/dashboard.dart';
import 'package:buruan/reminder.dart';

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
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buruan',
      home: const Login(),
      routes: routes,
    );
  }
}
