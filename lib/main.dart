import 'package:flutter/material.dart';
import 'package:my_app_groupproject/pages/cover_page.dart';
import 'package:my_app_groupproject/pages/login_page.dart';
import 'package:my_app_groupproject/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: LogInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

