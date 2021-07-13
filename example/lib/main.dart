import 'package:flutter/material.dart';

import 'src/index.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We-Link (Teams)',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: IndexPage(),
    );
  }
}
