import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:goferry/pages/order.dart';
import 'package:goferry/pages/displayFerry.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Go Ferry',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DisplayPage(),
    );
  }
}
