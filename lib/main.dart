import 'package:flutter/material.dart';
import 'package:rekam_corder/screens/main_record.dart';
import 'package:yaru/yaru.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: yaruLight,
      darkTheme: yaruDark,
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: MainRecord(),
      ),
    );
  }
}
