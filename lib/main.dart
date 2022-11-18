// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:buruan/AddReminder.dart';
import 'package:buruan/Dashboard.dart';
import 'package:buruan/Login.dart';
import 'package:flutter/material.dart';
import 'package:buruan/Register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routes = <String, WidgetBuilder>{
    Login.tag: (context) => const Login(),
    Register.tag: (context) => const Register(),
    AddReminder.tag: (context) => const AddReminder(),
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
