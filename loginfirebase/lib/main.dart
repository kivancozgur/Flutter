import 'package:flutter/material.dart';
import 'package:loginfirebase/ekranlar/girisekrani.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.green,
      debugShowCheckedModeBanner: false,
      home: GirisSayfasi(),
    );
  }
}