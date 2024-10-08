import 'package:flutter/material.dart';
import 'connect_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SensiFood App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ConnectPage(),
    );
  }
}